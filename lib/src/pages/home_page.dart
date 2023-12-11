import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mobile_20120598/src/components/header.dart';
import 'package:mobile_20120598/src/services/tutor_service.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:time_range_picker/time_range_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = <String>['Nước ngoài', 'Việt Nam', 'Bản địa'];
  String dropdownValue = "Nước ngoài";
  TimeRange timeRange =
      TimeRange(startTime: TimeOfDay.now(), endTime: TimeOfDay.now());
  TextEditingController dateInput = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TutorService tutorService = TutorService();
  int currentPage = 1;
  int totalPage = 1;
  late var data = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    data = (await tutorService.getTutors(1, 10))["data"];
  }

  _handleChangePage(index) async {
    data = (await tutorService.getTutors(index + 1, 10))["data"];
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var tutors = [];
    if (null != data &&
        null != data["tutors"] &&
        null != data["tutors"]["rows"]) {
      tutors = data["tutors"]["rows"];
      totalPage = data["tutors"]["count"];
    }
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
                        child: null != item["avatar"]
                            ? Image.network(item["avatar"],
                                height: 80, width: 80, fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                return Image.asset(
                                  "assets/images/teacher.jpg",
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                );
                              })
                            : Image.asset(
                                "assets/images/teacher.jpg",
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item["name"],
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w600),
                      ),
                      Icon(Icons.favorite_border),
                      Icon(Icons.favorite, color: Colors.red)
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/vi.svg",
                        height: 26,
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Text(item['country'] ?? "")
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
                  const Padding(padding: EdgeInsets.only(top: 26)),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(
                              top: 8, right: 12, left: 12, bottom: 8),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(221, 234, 254, 1),
                          ),
                          child: const Text("Tất cả",
                              style: TextStyle(color: Colors.blue))),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 8, right: 12, left: 12, bottom: 8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Color.fromRGBO(221, 234, 254, 1),
                        ),
                        child: const Text("Tiếng anh cho trẻ em",
                            style: TextStyle(color: Colors.blue)),
                      ),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 8, right: 12, left: 12, bottom: 8),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color.fromRGBO(221, 234, 254, 1),
                          ),
                          child: const Text("Tiếng anh cho công việc",
                              style: TextStyle(color: Colors.blue))),
                      Container(
                          padding: const EdgeInsets.only(
                              top: 8, right: 12, left: 12, bottom: 8),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
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
                      text: TextSpan(
                          style: TextStyle(color: Colors.black38, height: 1.5),
                          text: item["bio"] ?? "")),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/booking");
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
        .cast<Widget>()
        .toList();
    return Scaffold(
      body: Column(
        children: [
          const Header(login: true),
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
                          style: TextStyle(fontSize: 30, color: Colors.white)),
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
                            const Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 18),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Nhập tên gia sư..."),
                                  )),
                            ),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            DropdownButton<String>(
                              value: dropdownValue,
                              padding: const EdgeInsets.only(bottom: 0),
                              icon: const Icon(Icons.arrow_downward),
                              underline: Container(
                                height: 2,
                                color: Colors.black26,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                        const Text("Chọn một ngày có lịch trống"),
                        Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: dateInput,
                              //editing controller of this TextField
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                  //icon of text field
                                  labelText: "Enter Date" //label text of field
                                  ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
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
                                  TimeRange result = await showTimeRangePicker(
                                    context: context,
                                  );
                                  startTime.text =
                                      result.startTime.format(context);
                                  endTime.text = result.endTime.format(context);
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
                                  TimeRange result = await showTimeRangePicker(
                                    context: context,
                                  );
                                  startTime.text =
                                      result.startTime.format(context);
                                  endTime.text = result.endTime.format(context);
                                },
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.timer),
                                    //icon of text field
                                    labelText: "End time" //label text of field
                                    ),
                              ),
                            )
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
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
                                        color:
                                            Color.fromRGBO(100, 100, 100, 1)))),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 8, right: 12, left: 12, bottom: 8),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
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
                                        color:
                                            Color.fromRGBO(100, 100, 100, 1)))),
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
                                        color:
                                            Color.fromRGBO(100, 100, 100, 1))))
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 14)),
                        Container(
                            padding: const EdgeInsets.only(
                                top: 8, right: 12, left: 12, bottom: 8),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                border: Border(
                                  top: BorderSide(
                                      color: Color.fromRGBO(0, 113, 240, 1)),
                                  bottom: BorderSide(
                                      color: Color.fromRGBO(0, 113, 240, 1)),
                                  left: BorderSide(
                                      color: Color.fromRGBO(0, 113, 240, 1)),
                                  right: BorderSide(
                                      color: Color.fromRGBO(0, 113, 240, 1)),
                                )),
                            child: const Text("Đặt lại bộ tìm kiếm",
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 113, 240, 1)))),
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
                      ...tutorWidgets,
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      NumberPaginator(
                        numberPages: totalPage,
                        onPageChange: _handleChangePage,
                      )
                    ],
                  ),
                )
              ],
            ),
          ))
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
