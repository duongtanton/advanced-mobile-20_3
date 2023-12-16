import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_20120598/src/components/video.dart';
import 'package:mobile_20120598/src/constants/common.dart';
import 'package:mobile_20120598/src/dto/schedule_dto.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:mobile_20120598/src/services/booking_service.dart';
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
  TextEditingController bookingNote = TextEditingController();

  TutorService tutorService = TutorService();
  BookingService bookingService = BookingService();

  var tutor = null;
  var feedbacks = null;
  var fbCurrentPage = 1;
  var scCurrentPage = 1;
  var tutorId = null;
  var showReportForm = false;
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
            item['scheduleDetails'].map((e) => e['id']).toList()[0],
            'Đặt lịch',
            DateTime.fromMicrosecondsSinceEpoch(item['startTimestamp'] * 1000),
            DateTime.fromMicrosecondsSinceEpoch(item['endTimestamp'] * 1000),
            item?['isBooked']
                ? const Color(0xFF353836)
                : const Color(0xFF0F8644),
            false,
            item!['isBooked'] ?? false));
      });
    }
    setState(() {
      scheduleOfTutor = schedules;
    });
  }

  void _showReportFormPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Text('Báo cáo ${tutor['User']?['name']}',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          content: SizedBox(
            height: 400.0,
            // Your form widgets go here
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Bạn đang gặp vấn đề gì"),
                  const Divider(
                    height: 20.0,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                      const SizedBox(width: 8.0),
                      // Adjust the spacing between Checkbox and Text
                      const Expanded(
                        child: Text(
                          'Gia sư này làm phiền tôi',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                      const SizedBox(width: 8.0),
                      // Adjust the spacing between Checkbox and Text
                      const Expanded(
                        child: Text(
                          'Hồ sơ này giả mạo',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                      const SizedBox(width: 8.0),
                      // Adjust the spacing between Checkbox and Text
                      const Expanded(
                        child: Text(
                          'Ảnh hồ sơ không phù hợp',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  const TextField(
                    maxLines: 4, //or null
                    decoration: InputDecoration(
                      hintText: 'Vui lòng diễn tả chi tiết vấn đề của bạn',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add form submission logic here
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: const Text('Gửi'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBookingFormPopup(BuildContext context, dynamic schedule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: const Text('Chi tiết đặt lịch',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          content: SizedBox(
            height: 320.0,
            // Your form widgets go here
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Thời gian dặt"),
                  Text(
                      "   ${DateFormat('HH:mm').format(schedule.from)} - ${DateFormat('HH:mm').format(schedule.to)} ${DateFormat('dd/MM/yyyy').format(schedule.to)}"),
                  const Divider(
                    height: 20.0,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Text(
                        "Học phí: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 8.0),
                      // Adjust the spacing between Checkbox and Text
                      Expanded(
                        child: Text(
                          '10\$',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        "Số dư: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 8.0),
                      // Adjust the spacing between Checkbox and Text
                      Expanded(
                        child: Text(
                          '982 buổi học',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    maxLines: 4, //or null
                    decoration: const InputDecoration(
                      hintText: 'Ghi chú dành cho buổi học',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(),
                    ),
                    controller: bookingNote,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      bookingService.book([schedule.id], bookingNote.text);
                    },
                    child: const Text('Đặt'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _toggleFavorite() async {
    if (null == tutorId) {
      return;
    }
    var response = await tutorService.toggleFavorite(tutorId);
    if (response['success']) {
      setState(() {
        tutor['isFavorite'] = response['data'] != 1;
      });
    }
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
              child: Image.network(tutor["User"]["avatar"],
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover, errorBuilder: (BuildContext context,
                      Object exception, StackTrace? stackTrace) {
                return Image.asset(
                  "assets/images/teacher.jpg",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                );
              }),
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
                Row(
                    children:
                        CommonUtil.renderStars(tutor["rating"] ?? 5, 5, 18)),
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
            GestureDetector(
              onTap: () => _toggleFavorite(),
              child: Column(
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
            ),
            GestureDetector(
              onTap: () => {
                setState(() {
                  _showReportFormPopup(context);
                })
              },
              child: const Column(
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
              ),
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
                                    fb['rating'] ?? 5, 5, 12)),
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
        SizedBox(
            height: 600,
            child: SafeArea(
                child: SfCalendar(
              view: CalendarView.week,
              showTodayButton: true,
              showDatePickerButton: true,
              showNavigationArrow: true,
              firstDayOfWeek: 4,
              cellEndPadding: 5,
              timeZone: 'SE Asia Standard Time',
              timeSlotViewSettings: const TimeSlotViewSettings(
                  timeInterval: Duration(minutes: 15),
                  timeIntervalHeight: 100,
                  timeFormat: 'HH:mm'),
              minDate: DateTime.now(),
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.appointment) {
                  if (details.appointments?[0].isBooked) {
                    return;
                  }
                  _showBookingFormPopup(context, details.appointments?[0]);
                  print('Tapped on appointment: ${details.appointments?[0]}');
                } else if (details.targetElement ==
                    CalendarElement.calendarCell) {
                  print('Tapped on date: ${details.date}');
                }
              },
              dataSource: ScheduleDataSource(scheduleOfTutor),
              onViewChanged: (ViewChangedDetails viewChangedDetails) {
                final DateTime date = viewChangedDetails.visibleDates[6];
                scCurrentPage =
                    (date.difference(DateTime.now()).inDays / 7).ceil() - 1;
                _getScheduleDataSource();
              },
            ))),
        const Padding(padding: EdgeInsets.only(top: 50)),
      ];
    } else {
      tutorWidgets = [
        const Padding(padding: EdgeInsets.only(top: 20)),
        const Center(
          child: CircularProgressIndicator(),
        )
      ];
    }
    return MainLayout(
        screen: "booking_page",
        showNavigators: true,
        body: Container(
          padding:
              const EdgeInsets.only(bottom: 30, top: 26, left: 26, right: 26),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: tutorWidgets),
        ));
  }
}
