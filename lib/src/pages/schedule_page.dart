import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/components/header.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, required this.title});

  final String title;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _obscured = false;

  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      }
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(login: true),
          Expanded(
              child: SingleChildScrollView(
                  child: Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 90,
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const Text(
                  "Lịch đã đặt",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      const VerticalDivider(
                          thickness: 4, width: 30, color: Colors.black54),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                        child: RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: const StrutStyle(fontSize: 16.0),
                            maxLines: 100,
                            text: const TextSpan(
                                style: TextStyle(
                                    color: Colors.black38,
                                    height: 1.5,
                                    fontSize: 16),
                                text:
                                    "Đây là danh sách những khung giờ bạn đã đặt. Bạn có thể theo dõi khi nào buổi học bắt đầu, tham gia buổi học bằng một cú nhấp chuột hoặc có thể hủy buổi học trước 2 tiếng.")),
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.doc,
                      size: 90,
                      color: Colors.black54,
                    ),
                    Text(
                      "Chưa có lịch học nào",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, "/evaluate");
                      },
                      icon: const Icon(
                        IconData(0xe122, fontFamily: 'MaterialIcons'),
                        color: Colors.blue,
                      ),
                      label: const Text(
                        "Đặt lịch",
                        style: TextStyle(color: Colors.blue),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          )))
        ],
      ),
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
      ),
    );
  }
}
