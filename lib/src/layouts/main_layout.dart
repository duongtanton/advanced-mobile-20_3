import 'dart:convert';
import 'dart:math';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_20120598/src/bloc/Lang.dart';
import 'package:mobile_20120598/src/components/avatar.dart';
import 'package:mobile_20120598/src/lang/common.dart';
import 'package:mobile_20120598/src/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLayout extends StatefulWidget {
  const MainLayout(
      {super.key,
      required this.screen,
      required this.body,
      this.showNavigators = false});

  final String screen;
  final Widget body;
  final bool showNavigators;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

// For the testing purposes, you should probably use https://pub.dev/packages/uuid.
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class _MainLayoutState extends State<MainLayout> {
  List<dynamic> navigators = [
    {
      "name": "Tài khoản của tôi",
      "icon": Icons.ice_skating,
      "route": "/user",
    },
    {
      "name": "Gia sư",
      "icon": Icons.person,
      "route": "/",
    },
    {
      "name": "Lịch học",
      "icon": Icons.schedule,
      "route": "/schedule",
    },
    {
      "name": "Lịch sử",
      "icon": Icons.history,
      "route": "/evaluate",
    },
    {
      "name": "Khóa học",
      "icon": Icons.golf_course,
      "route": "/courses",
    },
    {
      "name": "Đăng kí làm gia sư",
      "icon": Icons.app_registration,
      "route": "/become-tutor",
    },
    {
      "name": "Đăng xuất",
      "icon": Icons.logout,
      "route": "sign-out",
    },
  ];
  List<dynamic> languages = [
    {"name": "Tiếng anh", "code": "en", "country": "US"},
    {"name": "Việt nam", "code": "vi", "country": "VN"},
  ];
  final UserService _userService = UserService();
  late SharedPreferences prefs;

  var user = null;
  var toUserId = null;
  var currentPageMessage = 1;
  List<dynamic> _messages = [];
  List<dynamic> _recipients = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    prefs = await SharedPreferences.getInstance();
    if (widget.showNavigators &&
        (prefs.getString('access_token') == null ||
            prefs.getString('refresh_token') == null)) {
      Navigator.pushNamed(context, "/sign-in");
      return;
    }
    await _getUserInfo();
    await _getAllRecipient();
    toUserId = _recipients![0]!["partner"]!["id"];
    await _getMessageById(toUserId);
  }

  Future<void> _getUserInfo() async {
    final response = await _userService.getCurrentInfo();
    if (response['success']) {
      setState(() {
        user = response['data'];
        prefs.setString('user', jsonEncode(user));
        navigators[0]["name"] = user["name"];
      });
    }
  }

  Future<void> _getAllRecipient() async {
    final response = await _userService.getAllRecipient();
    if (response['success']) {
      setState(() {
        _recipients = response['data'];
      });
    }
  }

  Future<void> _getMessageById(id) async {
    final response = await _userService.getMessageById(
      id: id,
      currentPage: currentPageMessage,
    );
    if (response['success']) {
      setState(() {
        _messages = response['data']["rows"];
      });
    }
  }

  void _showChatDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (BuildContext buildContext) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
          var toUser = _recipients.firstWhere((element) {
            return element!["partner"]!["id"] == toUserId;
          });
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Row(children: [
              Expanded(
                  child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    toUser!["partner"]!["name"] ?? "Tin nhắn mới",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Chat(
                      messages: _messages
                          .map((e) => types.TextMessage(
                                author: types.User(
                                  id: e!["fromInfo"]!["id"],
                                  firstName: e!["fromInfo"]!["name"],
                                ),
                                createdAt:
                                    DateTime.now().millisecondsSinceEpoch,
                                id: randomString(),
                                text: e["content"],
                              ))
                          .toList(),
                      onSendPressed: _handleSendPressed,
                      user: types.User(
                        id: user["id"],
                        firstName: user["name"],
                      )),
                ),
              ])),
              Container(
                width: 68,
                color: Colors.grey[200],
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(4),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _recipients.map((e) {
                      return GestureDetector(
                        onTap: () {
                          toUserId = e!["partner"]!["id"];
                          _getMessageById(toUserId)
                              .whenComplete(() => stateSetter(() {}));
                        },
                        child: Avatar(
                          url: e!["partner"]!["avatar"],
                          size: 60,
                        ),
                      );
                    }).toList()),
              ),
            ]),
          );
        });
      },
    );
  }

  void _addMessage(message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = {
      "partner": {"id": user["id"]},
      "fromInfo": {"id": user["id"]},
      "toInfo": {"id": toUserId},
      "content": message.text,
    };
    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalStateCubit, GlobalState>(
        builder: (context, globalState) {
      String lang = globalState.lang;
      String theme = globalState.theme;
      navigators = [
        {
          "name": user?["name"] ?? commonLang[lang]!["myAccount"],
          "icon": Icons.ice_skating,
          "route": "/user",
        },
        {
          "name": commonLang[lang]!["tutor"],
          "icon": Icons.person,
          "route": "/",
        },
        {
          "name": commonLang[lang]!["schedule"],
          "icon": Icons.schedule,
          "route": "/schedule",
        },
        {
          "name": commonLang[lang]!["history"],
          "icon": Icons.history,
          "route": "/evaluate",
        },
        {
          "name": commonLang[lang]!["course"],
          "icon": Icons.golf_course,
          "route": "/courses",
        },
        {
          "name": commonLang[lang]!["becomeTutor"],
          "icon": Icons.app_registration,
          "route": "/become-tutor",
        },
        {
          "name": commonLang[lang]!["theme-$theme"],
          "icon": Icons.mode_edit,
          "route": "theme",
        },
        {
          "name": commonLang[lang]!["signOut"],
          "icon": Icons.logout,
          "route": "sign-out",
        },
      ];
      languages = [
        {"name": commonLang[lang]!["english"], "code": "en", "country": "US"},
        {
          "name": commonLang[lang]!["vietnamese"],
          "code": "vi",
          "country": "VN"
        },
      ];
      return Scaffold(
          appBar: AppBar(
            leadingWidth: 180,
            leading: GestureDetector(
                onTap: () => Navigator.pushNamed(context, "/"),
                child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset("assets/images/logo.svg",
                        width: 180, height: 40))),
            backgroundColor: Colors.white,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: Colors.grey[300],
                  height: 1.0,
                )),
            actions: [
              PopupMenuButton(
                  itemBuilder: (BuildContext bc) => languages
                      .map((e) => PopupMenuItem(
                          value: lang,
                          onTap: () async {
                            context
                                .read<GlobalStateCubit>()
                                .changeLang(e["code"]);
                            await prefs.setString('lang', e["code"]);
                          },
                          child: Row(
                            children: [
                              CountryFlag.fromCountryCode(e["country"],
                                  width: 30, height: 40),
                              const Padding(
                                  padding: EdgeInsets.only(right: 10)),
                              Text(e["name"])
                            ],
                          )))
                      .toList(),
                  onSelected: (value) {},
                  icon: lang == "vi"
                      ? CountryFlag.fromCountryCode("VN", width: 30, height: 40)
                      : CountryFlag.fromCountryCode("US",
                          width: 30, height: 40),
                  position: PopupMenuPosition.under),
              const Padding(padding: EdgeInsets.only(right: 10)),
              widget.showNavigators
                  ? PopupMenuButton(
                      itemBuilder: (BuildContext bc) => navigators
                          .map((e) => PopupMenuItem(
                              value: e["name"],
                              onTap: () {
                                if (e["route"] == "theme") {
                                  context.read<GlobalStateCubit>().changeTheme(
                                      theme == "light" ? "dark" : "light");
                                  prefs.setString('theme',
                                      theme == "light" ? "dark" : "light");
                                  return;
                                }
                                if (e["route"] == "sign-out") {
                                  prefs.remove('user');
                                  prefs.remove('access_token');
                                  prefs.remove('refresh_token');
                                  Navigator.pushNamed(context, "/sign-in");
                                  return;
                                }
                                Navigator.pushNamed(context, e["route"]);
                              },
                              child: Row(
                                children: [
                                  e["route"] == "/user"
                                      ? Avatar(
                                          url: user != null
                                              ? user["avatar"]
                                              : "",
                                          size: 30)
                                      : Icon(e["icon"]),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 10)),
                                  Text(e["name"])
                                ],
                              )))
                          .toList(),
                      onSelected: (value) {},
                      icon: Avatar(
                          url: user != null ? user["avatar"] : "", size: 30),
                      position: PopupMenuPosition.under)
                  : Container(),
              const Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),
          body: Localizations.override(
              context: context,
              locale: Locale(lang),
              child: Builder(builder: (BuildContext context) {
                return SingleChildScrollView(child: widget.body);
              })),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: "Gift",
                onPressed: () => {},
                tooltip: 'Gift',
                child: const Icon(Icons.gif_box),
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              FloatingActionButton(
                heroTag: "Message",
                onPressed: () {
                  _showChatDialog(context);
                },
                tooltip: 'Message',
                child: const Icon(Icons.message),
              ),
            ],
          ));
    });
  }
}
