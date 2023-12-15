import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

class _MainLayoutState extends State<MainLayout> {
  List<dynamic> navigators = [
    {
      "name": "Phhai",
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
      "route": "/profile",
    },
    {
      "name": "Lịch sử",
      "icon": Icons.history,
      "route": "/history",
    },
    {
      "name": "Khóa học",
      "icon": Icons.golf_course,
      "route": "/courses",
    },
    {
      "name": "Đăng kí làm gia sư",
      "icon": Icons.app_registration_rounded,
      "route": "/register-teacher",
    },
    {
      "name": "Đăng xuất",
      "icon": Icons.logout,
      "route": "/login",
    },
  ];
  List<dynamic> languages = [
    {"name": "English", "code": "en", "country": "US"},
    {"name": "Việt nam", "code": "vi", "country": "VN"},
  ];

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
                        value: e["name"],
                        onTap: () => {},
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
                icon: CountryFlag.fromCountryCode('VN', width: 30, height: 40),
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
        body: widget.body,
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
              onPressed: () => {},
              tooltip: 'Message',
              child: const Icon(Icons.message),
            )
          ],
        ));
  }
}
