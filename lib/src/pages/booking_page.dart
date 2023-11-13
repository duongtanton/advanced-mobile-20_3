import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_20120598/src/components/header.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:readmore/readmore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:video_player/video_player.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.title});

  final String title;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = VideoPlayerController.networkUrl(Uri.parse(
          'https://api.app.lettutor.com/video/4d54d3d7-d2a9-42e5-97a2-5ed38af5789avideo1627913015871.mp4'))

        ..initialize().then((_) {
          setState(() {});
        });
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
                const EdgeInsets.only(bottom: 30, top: 26, left: 26, right: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: const Image(
                        image: AssetImage("assets/images/teacher.jpg"),
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Keegan",
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 6)),
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
                            ),
                            Text(
                              "(113)",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 6)),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/vi.svg",
                              height: 20,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            const Text("Vietnam")
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const ReadMoreText(
                  'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.',
                  trimLines: 2,
                  style: TextStyle(height: 1.3, color: Colors.black54),
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: 'Hide more',
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.blue,
                        ),
                        Text(
                          "Yêu thích",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.report_outlined,
                          color: Colors.blue,
                        ),
                        Text(
                          "Báo cáo",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )
                  ],
                ),
                Center(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : Container(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    const Text(
                      "Học vấn",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
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
                              color: Color.fromRGBO(228, 230, 235, 1),
                            ),
                            child: const Text("Tất cả",
                                style: TextStyle(
                                    color: Color.fromRGBO(100, 100, 100, 1)))),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 8, right: 12, left: 12, bottom: 8),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(228, 230, 235, 1),
                          ),
                          child: const Text("Tiếng anh cho trẻ em",
                              style: TextStyle(
                                  color: Color.fromRGBO(100, 100, 100, 1))),
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                top: 8, right: 12, left: 12, bottom: 8),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Color.fromRGBO(228, 230, 235, 1),
                            ),
                            child: const Text("Tiếng anh cho công việc",
                                style: TextStyle(
                                    color: Color.fromRGBO(100, 100, 100, 1)))),
                        Container(
                            padding: const EdgeInsets.only(
                                top: 8, right: 12, left: 12, bottom: 8),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Color.fromRGBO(228, 230, 235, 1),
                            ),
                            child: const Text("Giao tiếp",
                                style: TextStyle(
                                    color: Color.fromRGBO(100, 100, 100, 1))))
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    const Text(
                      "Chuyên ngành",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
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
                              color: Color.fromRGBO(228, 230, 235, 1),
                            ),
                            child: const Text("Tất cả",
                                style: TextStyle(
                                    color: Color.fromRGBO(100, 100, 100, 1)))),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 8, right: 12, left: 12, bottom: 8),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(228, 230, 235, 1),
                          ),
                          child: const Text("Tiếng anh cho trẻ em",
                              style: TextStyle(
                                  color: Color.fromRGBO(100, 100, 100, 1))),
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                top: 8, right: 12, left: 12, bottom: 8),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Color.fromRGBO(228, 230, 235, 1),
                            ),
                            child: const Text("Tiếng anh cho công việc",
                                style: TextStyle(
                                    color: Color.fromRGBO(100, 100, 100, 1)))),
                        Container(
                            padding: const EdgeInsets.only(
                                top: 8, right: 12, left: 12, bottom: 8),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Color.fromRGBO(228, 230, 235, 1),
                            ),
                            child: const Text("Giao tiếp",
                                style: TextStyle(
                                    color: Color.fromRGBO(100, 100, 100, 1))))
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    const Text(
                      "Khóa học tham khảo",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Basic Conversation Topics: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              Text(
                                "Tìm hiểu",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 14),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Row(
                            children: [
                              Text(
                                "Basic Conversation Topics: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              Text(
                                "Tìm hiểu",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      "Sở thích",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                        "I loved the weather, the scenery and the laid-back lifestyle of the locals.")
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      "Kinh nghiệm giảng dạy",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                        "I have more than 10 years of teaching english experience.")
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: const Image(
                        image: AssetImage("assets/images/teacher.jpg"),
                        height: 38,
                        width: 38,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Phhai",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Text("một ngày trước",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54)),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 6)),
                        Row(
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
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: const Image(
                        image: AssetImage("assets/images/teacher.jpg"),
                        height: 38,
                        width: 38,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Phhai",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Text("một ngày trước",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54)),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 6)),
                        Row(
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
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: const Image(
                        image: AssetImage("assets/images/teacher.jpg"),
                        height: 38,
                        width: 38,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Phhai",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Text("một ngày trước",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54)),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 6)),
                        Row(
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
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 16)),
                NumberPaginator(
                  numberPages: 10,
                  onPageChange: (int index) {
                    Navigator.pushNamed(context, '/schedule');
                    // handle page change...
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),
                SfCalendar(
                  view: CalendarView.week,
                  allowDragAndDrop: true,
                  allowAppointmentResize: true,
                  showTodayButton: true,
                  showDatePickerButton: true,
                  showNavigationArrow: true,
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
