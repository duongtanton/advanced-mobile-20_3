import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/components/header.dart';
import 'package:number_paginator/number_paginator.dart';

class CourseInfoPage extends StatefulWidget {
  const CourseInfoPage({super.key, required this.title});

  final String title;

  @override
  State<CourseInfoPage> createState() => _CourseInfoPageState();
}

class _CourseInfoPageState extends State<CourseInfoPage> {
  @override
  void initState() {
    super.initState();
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
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(right: 20, bottom: 20, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Basic Conversation Topics",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Padding(padding: EdgeInsets.only(top: 8)),
                            Text(
                                "Gain confidence speaking about familiar topics",
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                            Padding(padding: EdgeInsets.only(top: 30)),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Khám phá",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.only(
                                          top: 4,
                                          right: 20,
                                          left: 20,
                                          bottom: 4)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueAccent)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40)),
                Text(
                  "Tổng quan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Text(
                  "Tại sao bạn nên học khóa học này",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: const StrutStyle(fontSize: 16.0),
                    maxLines: 100,
                    text: const TextSpan(
                        style: TextStyle(
                            color: Colors.black54, height: 1.5, fontSize: 14),
                        text:
                            "It can be intimidating to speak with a foreigner, no matter how much grammar and vocabulary you've mastered. If you have basic knowledge of English but have not spent much time speaking, this course will help you ease into your first English conversations.")),
                Padding(padding: EdgeInsets.only(top: 20)),
                Text(
                  "Bạn có thể làm gì",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: const StrutStyle(fontSize: 16.0),
                    maxLines: 100,
                    text: const TextSpan(
                        style: TextStyle(
                            color: Colors.black54, height: 1.5, fontSize: 14),
                        text:
                            "This course covers vocabulary at the CEFR A2 level. You will build confidence while learning to speak about a variety of common, everyday topics. In addition, you will build implicit grammar knowledge as your tutor models correct answers and corrects your mistakes.")),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  "Trình độ yêu cầu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  "Thời lượng khóa học",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  "Danh sách chủ đề",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                NumberPaginator(
                  numberPages: 10,
                  onPageChange: (int index) {
                    // handle page change...
                    Navigator.popAndPushNamed(context, "/video-call");
                  },
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
