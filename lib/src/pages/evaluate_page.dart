import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:video_player/video_player.dart';

class EvaluatePage extends StatefulWidget {
  const EvaluatePage({super.key, required this.title});

  final String title;

  @override
  State<EvaluatePage> createState() => _EvaluatePageState();
}

class _EvaluatePageState extends State<EvaluatePage> {
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
    return MainLayout(
        screen: "evaluate_page",
        showNavigators: true,
        body: Column(
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/courses");
              },
              child: const Text(
                "Lịch sử các buổi học",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
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
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ], color: const Color.fromRGBO(239, 239, 240, 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("CN, 05 Thg 11 23",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                  const Text("1 week ago"),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 16, right: 16),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: const Image(
                                image: AssetImage("assets/images/teacher.jpg"),
                                height: 60,
                                width: 60,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/vi.svg",
                                  height: 20,
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
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  size: 16,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 26),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 16, right: 16),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text("Thời gian bài học : 19:30 - 19:55",
                        style: TextStyle(fontSize: 22)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 16, right: 16),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text("Không có yêu cầu cho buổi học",
                        style: TextStyle(fontSize: 16)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 16, right: 16),
                    margin: const EdgeInsets.only(top: 2),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text("Gia sư chưa có đánh giá",
                        style: TextStyle(fontSize: 16)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 16, right: 16),
                    margin: const EdgeInsets.only(top: 2),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Row(
                      children: [
                        Column(
                          children: [
                            Text("Raiting"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text("Sửa", style: TextStyle(color: Colors.blue))
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  size: 16,
                                )
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              "Báo cáo",
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 26)),
            Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ], color: const Color.fromRGBO(239, 239, 240, 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("CN, 05 Thg 11 23",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
                  const Text("1 week ago"),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 16, right: 16),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: const Image(
                                image: AssetImage("assets/images/teacher.jpg"),
                                height: 60,
                                width: 60,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/vi.svg",
                                  height: 20,
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
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  size: 16,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 26),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 16, right: 16),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text("Thời gian bài học : 19:30 - 19:55",
                        style: TextStyle(fontSize: 22)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 16, right: 16),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text("Không có yêu cầu cho buổi học",
                        style: TextStyle(fontSize: 16)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 16, right: 16),
                    margin: const EdgeInsets.only(top: 2),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text("Gia sư chưa có đánh giá",
                        style: TextStyle(fontSize: 16)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 16, right: 16),
                    margin: const EdgeInsets.only(top: 2),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Row(
                      children: [
                        Column(
                          children: [
                            Text("Raiting"),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text("Sửa", style: TextStyle(color: Colors.blue))
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Icon(
                                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                                  size: 16,
                                )
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              "Báo cáo",
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
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
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
