import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/components/header.dart';
import 'package:mobile_20120598/src/components/video.dart';
import 'package:mobile_20120598/src/constants/common.dart';
import 'package:mobile_20120598/src/dto/schedule_dto.dart';
import 'package:mobile_20120598/src/services/tutor_service.dart';
import 'package:mobile_20120598/src/util/common_util.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:readmore/readmore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timeago/timeago.dart' as timeago;

class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.title});

  final String title;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TutorService tutorService = TutorService();
  var tutor = null;
  var feedbacks = null;
  var fbCurrentPage = 1;
  var scCurrentPage = 1;
  var tutorId = null;
  List<Schedule> scheduleOfTutor = [];

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
    var fbResponse = await tutorService.getFeedback(tutorId: tutorId);
    if (response['success']) {
      setState(() {
        tutor = response['data'];
        feedbacks = fbResponse['data'];
      });
      _getScheduleDataSource();
    }
  }

  getFeedbacks() async {
    if (null == tutorId) {
      return;
    }
    var response =
        await tutorService.getFeedback(tutorId: tutorId, page: fbCurrentPage);
    if (response['success']) {
      setState(() {
        feedbacks = response['data'];
      });
    }
  }

  _getScheduleDataSource() async {
    if (null == tutorId) {
      return [];
    }
    var data = await tutorService.getTutorSchedules(tutorId, scCurrentPage);
    final List<Schedule> schedules = <Schedule>[];
    if (data['success']) {
      data['data'].forEach((item) {
        schedules.add(Schedule(
            'Đặt lịch',
            DateTime.fromMicrosecondsSinceEpoch(item['startTimestamp']* 1000),
            DateTime.fromMicrosecondsSinceEpoch(item['endTimestamp']* 1000),
            const Color(0xFF0F8644),
            false));
      });
    }
    scheduleOfTutor = schedules;
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    tutorId = null != args && null != args['tutorId'] ? args['tutorId'] : null;
    List<Widget> tutorWidgets;
    if (tutor != null) {
      tutorWidgets = [
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
                Row(
                  children: [
                    Text(
                      tutor["User"]?["name"] ?? "",
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 6)),
                Row(children: CommonUtil.renderStars(tutor["rating"], 5, 18)),
                const Padding(padding: EdgeInsets.only(top: 6)),
                Row(
                  children: [
                    CountryFlag.fromCountryCode(
                      tutor['User']?['country'] ?? "VN",
                      height: 26,
                      width: 30,
                      borderRadius: 8,
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    Text(CommonConstant.countryMap[tutor['User']?['country']] ??
                        "")
                  ],
                ),
              ],
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        ReadMoreText(
          tutor["bio"] ?? "",
          trimLines: 2,
          style: const TextStyle(height: 1.3, color: Colors.black54),
          colorClickableText: Colors.blue,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Read more',
          trimExpandedText: 'Hide more',
          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                tutor?["isFavorite"]
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border, color: Colors.blue),
                const Text(
                  "Yêu thích",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            const Column(
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                                top: 8, right: 12, left: 12, bottom: 8),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                color: Color.fromRGBO(221, 234, 254, 1)),
                            child: Text(CommonConstant.specialties[item] ?? "",
                                style: const TextStyle(color: Colors.blue))),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                                top: 8, right: 12, left: 12, bottom: 8),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                color: Color.fromRGBO(221, 234, 254, 1)),
                            child: Text(CommonConstant.languageMap[item] ?? "",
                                style: const TextStyle(color: Colors.blue))),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: tutor['User']?['courses']
                        .map<Widget>(
                          (course) => Row(
                            children: [
                              Text(
                                "${course['name']}: ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              const Text(
                                "Tìm hiểu",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 14),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10))
                            ],
                          ),
                        )
                        .toList() ??
                    [],
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              "Sở thích",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text(tutor['interests'])
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              "Kinh nghiệm giảng dạy",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text(tutor['experience'])
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 30)),
        const Text(
          "Người khác đánh giá",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        ...null != feedbacks
            ? feedbacks['rows']
                .map<Widget>((fb) => Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.network(
                            fb['firstInfo']?['avatar'],
                            height: 38,
                            width: 38,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  fb['firstInfo']?['name'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 8)),
                                Text(
                                    timeago.format(
                                        DateTime.parse(fb['createdAt']),
                                        locale: 'vi'),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54)),
                              ],
                            ),
                            Text(
                              " ${fb['content'] ?? ''}",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 6)),
                            Row(
                                children: CommonUtil.renderStars(
                                    fb['rating'], 5, 12)),
                            const Padding(padding: EdgeInsets.only(top: 20))
                          ],
                        ),
                      ],
                    ))
                .toList()
            : [],
        const Padding(padding: EdgeInsets.only(top: 16)),
        null != feedbacks && feedbacks?['count'] > 0
            ? NumberPaginator(
                numberPages: feedbacks['count'],
                onPageChange: (int index) {
                  fbCurrentPage = index + 1;
                  getFeedbacks();
                },
              )
            : const Text("Không có đánh giá nào"),
        const Padding(padding: EdgeInsets.only(top: 40)),
        SfCalendar(
          view: CalendarView.week,
          showTodayButton: true,
          showDatePickerButton: true,
          showNavigationArrow: true,
          minDate: DateTime.now(),
          dataSource: ScheduleDataSource(scheduleOfTutor),
          onViewChanged: (ViewChangedDetails viewChangedDetails) {
            final DateTime date = viewChangedDetails.visibleDates[6];
            scCurrentPage = (date.difference(DateTime.now()).inDays / 7).ceil() - 1;
            _getScheduleDataSource();
          },
        )
      ];
    } else {
      tutorWidgets = [
        const Padding(padding: EdgeInsets.only(top: 20)),
        const Center(
          child: CircularProgressIndicator(),
        )
      ];
    }
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
                children: tutorWidgets),
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
