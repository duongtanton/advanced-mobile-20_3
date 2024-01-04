import 'dart:convert';
import 'dart:math';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_20120598/src/components/avatar.dart';
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
  String currentLanguage = "vi";
  List<dynamic> navigators = [
    {
      "name": "Tài khoản của tôi",
      "icon": Icons.ice_skating,
      "route": "/user",
    },
    {
      "name": "Lịch học định kì",
      "icon": Icons.book,
      "route": "/schedule-lesson",
    },
    {
      "name": "Gia sư",
      "icon": Icons.person,
      "route": "/teacher",
    },
    {
      "name": "Lịch học",
      "icon": Icons.person_off,
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
      "icon": Icons.app_registration_rounded,
      "route": "/become-tutor",
    },
    {
      "name": "Đăng xuất",
      "icon": Icons.logout,
      "route": "/sign-in",
    },
  ];
  List<dynamic> languages = [
    {"name": "English", "code": "en", "country": "US"},
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
    await _getUserInfo();
    await _getAllRecipient();
    toUserId = _recipients![0]!["toInfo"]!["id"];
    await _getMessageById(toUserId);
  }

  _getUserInfo() async {
    final response = await _userService.getCurrentInfo();
    if (response['success']) {
      setState(() {
        user = response['data'];
        prefs.setString('user', jsonEncode(user));
        navigators[0]["name"] = user["name"];
      });
    }
  }

  _getAllRecipient() async {
    final response = await _userService.getAllRecipient();
    if (response['success']) {
      setState(() {
        _recipients = response['data'];
      });
    }
  }

  _getMessageById(id) async {
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
    var toUser = _recipients.firstWhere((element) {
      return element!["toInfo"]!["id"] == toUserId;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Row(children: [
            Expanded(
                child: Column(children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  toUser!["toInfo"]!["name"] ?? "Tin nhắn mới",
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
                              createdAt: DateTime.now().millisecondsSinceEpoch,
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
                        toUserId = e!["toInfo"]!["id"];
                        _getMessageById(toUserId);
                      },
                      child: Avatar(
                        url: e!["toInfo"]!["avatar"],
                        size: 60,
                      ),
                    );
                  }).toList()),
            ),
          ]),
        );
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
                        value: currentLanguage,
                        onTap: () => {
                              setState(() {
                                currentLanguage = e["code"];
                              })
                            },
                        child: Row(
                          children: [
                            CountryFlag.fromCountryCode(e["country"],
                                width: 30, height: 40),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            Text(e["name"])
                          ],
                        )))
                    .toList(),
                onSelected: (value) {},
                icon: currentLanguage == "vi"
                    ? CountryFlag.fromCountryCode("VN", width: 30, height: 40)
                    : CountryFlag.fromCountryCode("US", width: 30, height: 40),
                position: PopupMenuPosition.under),
            const Padding(padding: EdgeInsets.only(right: 10)),
            widget.showNavigators
                ? PopupMenuButton(
                    itemBuilder: (BuildContext bc) => navigators
                        .map((e) => PopupMenuItem(
                            value: e["name"],
                            onTap: () =>
                                Navigator.pushNamed(context, e["route"]),
                            child: Row(
                              children: [
                                Icon(e["icon"]),
                                const Padding(
                                    padding: EdgeInsets.only(right: 10)),
                                Text(e["name"])
                              ],
                            )))
                        .toList(),
                    onSelected: (value) {},
                    icon: const Icon(Icons.account_circle),
                    position: PopupMenuPosition.under)
                : Container(),
            const Padding(padding: EdgeInsets.only(right: 10)),
          ],
        ),
        body: Localizations.override(
            context: context,
            locale: Locale(currentLanguage),
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
  }
}
