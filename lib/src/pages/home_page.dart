import 'dart:async';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_20120598/src/constants/common.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:mobile_20120598/src/services/tutor_service.dart';
import 'package:mobile_20120598/src/util/common_util.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:time_range_picker/time_range_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String> locations = {
    'all': 'Quốc gia',
    'isVietnamese': 'Việt Nam',
    'isNative': 'Bản địa',
    'onboarded': 'Nước ngoài'
  };

  String selectedLocation = 'all';
  String selectedSpecialty = 'all';
  TimeRange timeRange =
      TimeRange(startTime: TimeOfDay.now(), endTime: TimeOfDay.now());
  TextEditingController dateInput = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController searchText = TextEditingController();
  Timer? _debounce;

  TutorService tutorService = TutorService();
  int currentPage = 1;
  int totalPage = 1;
  var tutors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  _asyncMethod() async {
    await _search();
  }

  _handleChangePage(index) async {
    currentPage = index + 1;
    _search();
  }

  _search() async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () async {
      var data = (await tutorService.getTutors(
        page: currentPage,
        search: searchText.text,
        nationality: selectedLocation,
        specialties: selectedSpecialty,
        date: dateInput.text,
        tutoringTimeAvailableStart: startTime.text,
        tutoringTimeAvailableEnd: endTime.text,
      ))["data"];
      setState(() {
        if (null != data) {
          tutors = data["rows"];
          totalPage = data["count"];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tutorWidgets = tutors
        .map((item) => Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 20, right: 20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(item["avatar"],
                            height: 80, width: 80, fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                          return Image.asset(
                            "assets/images/teacher.jpg",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          );
                        }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item["name"],
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600),
                      ),
                      item["isFavoriteTutor"] == true
                          ? const Icon(Icons.favorite_border)
                          : const Icon(Icons.favorite, color: Colors.red),
                    ],
                  ),
                  Row(
                    children: [
                      CountryFlag.fromCountryCode(
                        item['country'] ?? "VN",
                        height: 26,
                        width: 30,
                        borderRadius: 8,
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Text(CommonConstant.countryMap[item['country']] ?? "")
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  Row(
                    children:
                        CommonUtil.renderStars(item['rating'] ?? 5, 5, 13),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 26)),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: null != item["specialties"]
                        ? item["specialties"]
                            .split(',')
                            .map<Widget>(
                              (item) => Container(
                                  padding: const EdgeInsets.only(
                                      top: 8, right: 12, left: 12, bottom: 8),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      color: Color.fromRGBO(221, 234, 254, 1)),
                                  child: Text(
                                      CommonConstant.specialties[item] ?? "",
                                      style:
                                          const TextStyle(color: Colors.blue))),
                            )
                            .toList()
                        : [],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: const StrutStyle(fontSize: 12.0),
                      maxLines: 4,
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.black38, height: 1.5),
                          text: item["bio"] ?? "")),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, "/booking",
                              arguments: {'tutorId': item["id"]});
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
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.blue))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
        .toList();
    List<DropdownMenuItem<String>> locationWidgets = locations.entries
        .map((entry) => DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            ))
        .toList();

    List<Widget> specialtyWidgets = CommonConstant.specialties.entries
        .map(
          (entry) => GestureDetector(
              onTap: () {
                selectedSpecialty = entry.key;
                _search();
              },
              child: Container(
                  padding: const EdgeInsets.only(
                      top: 8, right: 12, left: 12, bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: entry.key == selectedSpecialty
                        ? const Color.fromRGBO(221, 234, 254, 1)
                        : const Color.fromRGBO(228, 230, 235, 1),
                  ),
                  child: Text(entry.value,
                      style: TextStyle(
                          color: entry!.key == selectedSpecialty
                              ? Colors.blue
                              : const Color.fromRGBO(100, 100, 100, 1))))),
        )
        .toList();
    return MainLayout(
        screen: "home_page",
        showNavigators: true,
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    padding: const EdgeInsets.only(
                        top: 46, bottom: 30, left: 30, right: 30),
                    child: const Column(
                      children: [
                        Text("Bạn không có buổi học nào.",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                        Padding(padding: EdgeInsets.only(top: 26)),
                        Text(
                          "Chào mừng bạn đến với Letutor.",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
                    padding: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromRGBO(100, 100, 100, 1)))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tìm kiếm gia sư",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 20)),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(bottom: 18),
                                    child: TextField(
                                        decoration: const InputDecoration(
                                            hintText: "Nhập tên gia sư..."),
                                        controller: searchText,
                                        onChanged: (text) {
                                          _search();
                                        })),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(right: 10)),
                              DropdownButton<String>(
                                value: selectedLocation,
                                padding: const EdgeInsets.only(bottom: 0),
                                icon: const Icon(Icons.arrow_downward),
                                underline: Container(
                                  height: 2,
                                  color: Colors.black26,
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedLocation = value!;
                                    _search();
                                  });
                                },
                                items: locationWidgets,
                              )
                            ],
                          ),
                          const Text("Chọn một ngày có lịch trống"),
                          Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: dateInput,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.calendar_today),
                                    labelText: "Enter Date"),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100));
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    setState(() {
                                      dateInput.text = formattedDate;
                                    });
                                    _search();
                                  } else {}
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  controller: startTime,
                                  onTap: () async {
                                    TimeRange result =
                                        await showTimeRangePicker(
                                      context: context,
                                    );
                                    startTime.text =
                                        result.startTime.format(context);
                                    endTime.text =
                                        result.endTime.format(context);
                                    _search();
                                  },
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.timer),
                                      //icon of text field
                                      labelText:
                                          "Start time" //label text of field
                                      ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  controller: endTime,
                                  onTap: () async {
                                    TimeRange result =
                                        await showTimeRangePicker(
                                      context: context,
                                    );
                                    startTime.text =
                                        result.startTime.format(context);
                                    endTime.text =
                                        result.endTime.format(context);
                                    _search();
                                  },
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.timer),
                                      //icon of text field
                                      labelText:
                                          "End time" //label text of field
                                      ),
                                ),
                              )
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          Wrap(
                            spacing: 12,
                            runSpacing: 6,
                            children: specialtyWidgets,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 14)),
                          GestureDetector(
                            onTap: () {
                              selectedLocation = "all";
                              selectedSpecialty = "all";
                              dateInput.text = "";
                              startTime.text = "";
                              endTime.text = "";
                              searchText.text = "";
                              _search();
                            },
                            child: Container(
                                padding: const EdgeInsets.only(
                                    top: 8, right: 12, left: 12, bottom: 8),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    border: Border(
                                      top: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 113, 240, 1)),
                                      bottom: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 113, 240, 1)),
                                      left: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 113, 240, 1)),
                                      right: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 113, 240, 1)),
                                    )),
                                child: const Text("Đặt lại bộ tìm kiếm",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(0, 113, 240, 1)))),
                          )
                        ]),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 14)),
                  Container(
                    margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Row(children: [
                          Text("Gia sư được đề xuất",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 22)),
                        ]),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        totalPage > 0
                            ? Column(
                                children: [
                                  ...tutorWidgets,
                                  NumberPaginator(
                                    numberPages: totalPage,
                                    onPageChange: _handleChangePage,
                                  )
                                ],
                              )
                            : const Text("Không có kết quả tìm kiếm"),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
