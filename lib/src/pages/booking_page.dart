import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_20120598/src/components/header.dart';
import 'package:mobile_20120598/src/components/video.dart';
import 'package:mobile_20120598/src/constants/common.dart';
import 'package:mobile_20120598/src/services/tutor_service.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:readmore/readmore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.title});

  final String title;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TutorService tutorService = TutorService();
  var tutor = {};
  var tutorId = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    if (null == tutorId) {
      return;
    }
    var response = await tutorService.getTutorById(tutorId);
    if (response['success']) {
      setState(() {
        tutor = response['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    tutorId = null != args && null != args['tutorId'] ? args['tutorId'] : null;
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
              children: null == tutor
                  ? [
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ]
                  : [
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
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.only(top: 6)),
                              const Row(
                                children: [
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
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
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10)),
                                  const Text("Vietnam")
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ReadMoreText(
                        tutor["bio"],
                        trimLines: 2,
                        style:
                            const TextStyle(height: 1.3, color: Colors.black54),
                        colorClickableText: Colors.blue,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read more',
                        trimExpandedText: 'Hide more',
                        moreStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
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
                      Video(url: tutor["video"]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          const Text(
                            "Học vấn",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Text(tutor["education"])
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          const Text(
                            "Chuyên ngành",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Wrap(
                            spacing: 12,
                            runSpacing: 6,
                            children: null != tutor["specialties"]
                                ? tutor["specialties"]
                                    .split(',')
                                    .map<Widget>(
                                      (item) => Container(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 12,
                                              left: 12,
                                              bottom: 8),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16)),
                                              color: Color.fromRGBO(
                                                  221, 234, 254, 1)),
                                          child: Text(
                                              CommonConstant
                                                      .specialties[item] ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.blue))),
                                    )
                                    .toList()
                                : [],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          const Text(
                            "Ngôn ngữ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Wrap(
                            spacing: 12,
                            runSpacing: 6,
                            children: null != tutor["languages"]
                                ? tutor["languages"]
                                    .split(',')
                                    .map<Widget>(
                                      (item) => Container(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              right: 12,
                                              left: 12,
                                              bottom: 8),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16)),
                                              color: Color.fromRGBO(
                                                  221, 234, 254, 1)),
                                          child: Text(
                                              CommonConstant
                                                      .languageMap[item] ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Colors.blue))),
                                    )
                                    .toList()
                                : [],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          const Text(
                            "Khóa học tham khảo",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
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
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Tìm hiểu",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 14),
                                    ),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Row(
                                  children: [
                                    Text(
                                      "Basic Conversation Topics: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Tìm hiểu",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 14),
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
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
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
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
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
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
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  Icon(
                                    IconData(0xe5f9,
                                        fontFamily: 'MaterialIcons'),
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
                          Navigator.popAndPushNamed(context, '/schedule');
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
}
