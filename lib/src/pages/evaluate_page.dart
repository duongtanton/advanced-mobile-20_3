import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/components/avatar.dart';
import 'package:mobile_20120598/src/constants/common.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:mobile_20120598/src/services/booking_service.dart';
import 'package:mobile_20120598/src/util/common_util.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:timeago/timeago.dart' as timeago;

class EvaluatePage extends StatefulWidget {
  const EvaluatePage({super.key, required this.title});

  final String title;

  @override
  State<EvaluatePage> createState() => _EvaluatePageState();
}

class _EvaluatePageState extends State<EvaluatePage> {
  BookingService _bookingService = BookingService();
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
    await _getSchedule();
  }

  _getSchedule() async {
    _bookingService
        .getBookings(
            page: currentPage, perPage: 10, inFuture: 0, sortBy: "desc")
        .then((response) {
      if (response['success']) {
        setState(() {
          schedules = response['data']['rows'];
          totalPage = response['data']['count'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        screen: "evaluate_page",
        showNavigators: true,
        body: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                                  "Đây là danh sách các bài học bạn đã tham gia. "
                                  "Bạn có thể xem lại thông tin chi tiết về các "
                                  "buổi học đã tham gia đã tham gia.")),
                    )
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              ...schedules.isNotEmpty
                  ? schedules.map((item) {
                      var scheduleDetailInfo = item?['scheduleDetailInfo'];
                      var scheduleInfo = scheduleDetailInfo?['scheduleInfo'];
                      var tutorInfo = scheduleInfo?['tutorInfo'];
                      var feedbacks = item?['feedbacks'].isNotEmpty
                          ? item['feedbacks'][0]
                          : null;
                      return Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: Avatar(url: tutorInfo['avatar']),
                                      )
                                    ],
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 20)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            tutorInfo['name'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CountryFlag.fromCountryCode(
                                            tutorInfo['country'] ?? "VN",
                                            height: 20,
                                            width: 20,
                                            borderRadius: 8,
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4)),
                                          Text(CommonConstant.countryMap[
                                                  tutorInfo['country']] ??
                                              "")
                                        ],
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 4)),
                                      const Row(
                                        children: [
                                          Icon(
                                            IconData(0xe5f9,
                                                fontFamily: 'MaterialIcons'),
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          Icon(
                                            IconData(0xe5f9,
                                                fontFamily: 'MaterialIcons'),
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          Icon(
                                            IconData(0xe5f9,
                                                fontFamily: 'MaterialIcons'),
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          Icon(
                                            IconData(0xe5f9,
                                                fontFamily: 'MaterialIcons'),
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          Icon(
                                            IconData(0xe5f9,
                                                fontFamily: 'MaterialIcons'),
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
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Text(
                                  "Thời gian bài học "
                                  "${scheduleInfo["startTime"]} "
                                  "- ${scheduleInfo["endTime"]} "
                                  "${scheduleInfo["date"]}",
                                  style: const TextStyle(fontSize: 22)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 16, right: 16),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Text("Không có yêu cầu cho buổi học",
                                  style: TextStyle(fontSize: 16)),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 16, right: 16),
                              margin: const EdgeInsets.only(top: 2),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Text("Gia sư chưa có đánh giá",
                                  style: TextStyle(fontSize: 16)),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 16, right: 16),
                              margin: const EdgeInsets.only(top: 2),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Row(
                                children: [
                                  const Column(
                                    children: [
                                      Text("Raiting"),
                                      Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      Text("Sửa",
                                          style: TextStyle(color: Colors.blue))
                                    ],
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 20)),
                                  Column(
                                    children: [
                                      Row(
                                        children: null != feedbacks
                                            ? CommonUtil.renderStars(
                                                feedbacks["rating"] ?? 5, 5, 18)
                                            : [const Text("Chưa có đánh giá")],
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      const Text(
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
                      );
                    })
                  : [
                      const Center(
                        child: Text("Bạn chưa có lịch sử học tập"),
                      )
                    ],
              NumberPaginator(
                numberPages: totalPage,
                onPageChange: (int index) {
                  currentPage = index + 1;
                  _getSchedule();
                },
              )
            ],
          ),
        ));
  }
}
