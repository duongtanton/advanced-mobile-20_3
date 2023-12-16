import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/components/avatar.dart';
import 'package:mobile_20120598/src/constants/common.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:mobile_20120598/src/services/booking_service.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:timeago/timeago.dart' as timeago;

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, required this.title});

  final String title;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  BookingService bookingService = BookingService();
  Map<String, String> reasons = {
    "1": "Đặng lịch lại vào một thời gian khác",
    "2": "Lúc đó bận",
    "3": "Được yêu cầu bởi gia sư",
    "4": "Lý do khác"
  };

  List<dynamic> schedules = [];
  var totalPage = 1;
  var currentPage = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    var response = await bookingService.getBookings(page: currentPage);
    if (response['success']) {
      setState(() {
        schedules = response['data']['rows'] ?? [];
        totalPage = response['data']['count'] ?? 0;
      });
    }
  }

  _handleChangePage(int page) async {
    setState(() {
      currentPage = page;
    });
    await _asyncMethod();
  }

  void _showCancelFormPopup(BuildContext context, dynamic schedule) {
    var scheduleDetailInfo = schedule?['scheduleDetailInfo'];
    var scheduleInfo = scheduleDetailInfo?['scheduleInfo'];
    var tutorInfo = scheduleInfo?['tutorInfo'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2))),
          title: const Text('Hủy buổi học',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          content: SizedBox(
            height: 480.0,
            // Your form widgets go here
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Avatar(url: tutorInfo['avatar']),
                      Text(
                        tutorInfo['name'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      const Text("Thời gian bài học"),
                      Text(
                          "${scheduleInfo["startTime"]} - ${scheduleInfo["endTime"]} ${scheduleInfo["date"]}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 10.0,
                    indent: 10.0,
                    endIndent: 10.0,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "* Lý do hủy buổi học",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.red),
                  ),
                  DropdownButton<String>(
                    padding: const EdgeInsets.only(bottom: 0),
                    icon: const Icon(Icons.thumb_down_alt_sharp),
                    underline: Container(
                      height: 2,
                      color: Colors.black26,
                    ),
                    onChanged: (String? value) {
                      setState(() {});
                    },
                    items: reasons.entries
                        .map((entry) => DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(entry.value),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    maxLines: 4, //or null
                    decoration: InputDecoration(
                      hintText: 'Ghi chú thêm',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add form submission logic here
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: const Text('Xác nhận hủy'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> scheduleWidgets = [
      ...schedules.map((e) {
        var scheduleDetailInfo = e?['scheduleDetailInfo'];
        var scheduleInfo = scheduleDetailInfo?['scheduleInfo'];
        var tutorInfo = scheduleInfo?['tutorInfo'];
        return Container(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
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
              Text(scheduleInfo['date'],
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w600)),
              Text(timeago.format(
                  DateTime.fromMicrosecondsSinceEpoch(
                      scheduleInfo['startTimestamp'] * 1000),
                  locale: 'vi')),
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
                          child: Image.network(tutorInfo['avatar'],
                              height: 60, width: 60, fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                            return Image.asset(
                              "assets/images/teacher.jpg",
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            );
                          }),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              tutorInfo['name'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CountryFlag.fromCountryCode(
                              tutorInfo['country'] ?? "VN",
                              height: 20,
                              width: 25,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            Text(CommonConstant
                                    .countryMap[tutorInfo['country']] ??
                                "")
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 4)),
                        Row(
                          children: [
                            const Icon(
                              Icons.message,
                              color: Colors.blue,
                              size: 20,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 6)),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Nhắn tin",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${scheduleInfo["startTime"]} - ${scheduleInfo["endTime"]}",
                            style: const TextStyle(fontSize: 22)),
                        TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.only(
                                        top: 4,
                                        right: 20,
                                        left: 20,
                                        bottom: 4)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            child: GestureDetector(
                              onTap: () {
                                _showCancelFormPopup(context, e);
                              },
                              child: const Text(
                                "Hủy",
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                      ],
                    ),
                    ExpansionTile(
                      backgroundColor: Colors.black12,
                      title: Row(
                        children: [
                          Expanded(
                              child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  strutStyle: const StrutStyle(fontSize: 16.0),
                                  maxLines: 100,
                                  text: const TextSpan(
                                      style: TextStyle(
                                          color: Colors.black87,
                                          height: 1.5,
                                          fontSize: 16),
                                      text: "Yêu cầu cho buổi học"))),
                          Expanded(
                              child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  strutStyle: const StrutStyle(fontSize: 16.0),
                                  maxLines: 100,
                                  text: const TextSpan(
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          height: 1.5,
                                          fontSize: 16),
                                      text: "Chỉnh sửa yêu cầu"))),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      children: const <Widget>[
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text("Không có yêu cầu cho buổi học",
                            style: TextStyle(fontSize: 16)),
                        Padding(padding: EdgeInsets.only(top: 20)),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                top: 4, right: 20, left: 20, bottom: 4)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    child: const Text(
                      "Vào buổi học",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }).toList(),
      const Padding(padding: EdgeInsets.only(top: 20)),
      NumberPaginator(
        numberPages: totalPage,
        onPageChange: _handleChangePage,
      )
    ];
    return MainLayout(
        screen: "schedule",
        showNavigators: true,
        body: Container(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 40),
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
                ...schedules.isEmpty
                    ? [
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
                        ),
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
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            )
                          ],
                        )
                      ]
                    : scheduleWidgets,
              ],
            )));
  }
}
