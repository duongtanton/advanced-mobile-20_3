import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_20120598/src/components/header.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:video_player/video_player.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key, required this.title});

  final String title;

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = VideoPlayerController.networkUrl(Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
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
                    padding:
                    const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              CupertinoIcons.phone_circle,
                              size: 90,
                            )
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        const Text(
                          "Lịch sử các buổi học",
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
                                        "Đây là danh sách các bài học bạn đã tham gia. Bạn có thể xem lại thông tin chi tiết về các buổi học đã tham gia đã tham gia.")),
                              )
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 40)),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: const Image(
                                          image:
                                          AssetImage("assets/images/teacher.jpg"),
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Padding(padding: EdgeInsets.only(left: 20)),
                                  Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Keegan",
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/vi.svg",
                                            height: 26,
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.only(left: 10)),
                                          const Text("Vietnam")
                                        ],
                                      ),
                                      const Padding(padding: EdgeInsets.only(top: 4)),
                                      const Row(
                                        children: [
                                          Icon(
                                            IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          Icon(
                                            IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          Icon(
                                            IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          Icon(
                                            IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          Icon(
                                            IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Padding(padding: EdgeInsets.only(top: 26)),
                              Wrap(
                                spacing: 12,
                                runSpacing: 6,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 12, left: 12, bottom: 8),
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                        color: Color.fromRGBO(221, 234, 254, 1),
                                      ),
                                      child: const Text("Tất cả",
                                          style: TextStyle(color: Colors.blue))),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 8, right: 12, left: 12, bottom: 8),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                      color: Color.fromRGBO(221, 234, 254, 1),
                                    ),
                                    child: const Text("Tiếng anh cho trẻ em",
                                        style: TextStyle(color: Colors.blue)),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 12, left: 12, bottom: 8),
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                        color: Color.fromRGBO(221, 234, 254, 1),
                                      ),
                                      child: const Text("Tiếng anh cho công việc",
                                          style: TextStyle(color: Colors.blue))),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 12, left: 12, bottom: 8),
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                        color: Color.fromRGBO(221, 234, 254, 1),
                                      ),
                                      child: const Text("Giao tiếp",
                                          style: TextStyle(color: Colors.blue)))
                                ],
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: const StrutStyle(fontSize: 12.0),
                                maxLines: 4,
                                text: const TextSpan(
                                    style: TextStyle(
                                        color: Colors.black38, height: 1.5),
                                    text:
                                    'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.'),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: (){
                                      Navigator.pushNamed(context, "/booking");
                                    },
                                    icon: const Icon(
                                      IconData(0xe122,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.blue,
                                    ),
                                    label: const Text(
                                      "Đặt lịch",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color: Colors.blue))),
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 26)),
                        NumberPaginator(
                          numberPages: 10,
                          onPageChange: (int index) {

                            // handle page change...
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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
