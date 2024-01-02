import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:mobile_20120598/src/services/course_service.dart';
import 'package:number_paginator/number_paginator.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key, required this.title});

  final String title;

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  CourseService courseService = CourseService();

  List<dynamic> objects = [];
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
    await _getCourse();
  }

  _getCourse() async {
    final response =
        await courseService.getCourse(currentPage: currentPage, perPage: 10);
    if (response['success']) {
      setState(() {
        objects = response['data']["rows"];
        totalPage = response['data']['count'];
      });
    }
  }

  _getEbook() async {
    final response =
        await courseService.getEbook(currentPage: currentPage, perPage: 10);
    if (response['success']) {
      setState(() {
        objects = response['data']["rows"];
        totalPage = response['data']['count'];
      });
    }
  }

  _getInteractive() async {
    final response = await courseService.getInteractiveEbook(
        currentPage: currentPage, perPage: 10);
    if (response['success']) {
      setState(() {
        objects = response['data']["rows"];
        totalPage = response['data']['count'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        screen: "courses_page",
        showNavigators: true,
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/course-info");
                        },
                        child: const Icon(
                          CupertinoIcons.upload_circle,
                          size: 90,
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        text: "Khám phá các khóa học",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              IntrinsicHeight(
                child: Row(
                  children: [
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
                              text: "LiveTutor đã xây dựng nên các khóa học "
                                  "của các lĩnh vực trong cuộc sống chất lượng,"
                                  " bài bản và khoa học nhất cho những người "
                                  "đang có nhu cầu trau dồi thêm kiến thức về "
                                  "các lĩnh vực.")),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: EasyAutocomplete(
                          decoration:
                              const InputDecoration(hintText: "Khóa học"),
                          suggestions: const [
                            'Afeganistan',
                            'Albania',
                            'Algeria',
                            'Australia',
                            'Brazil',
                            'German',
                            'Madagascar',
                            'Mozambique',
                            'Portugal',
                            'Zambia'
                          ],
                          onChanged: (value) =>
                              print('onChanged value: $value'),
                          onSubmitted: (value) =>
                              print('onSubmitted value: $value'))),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Expanded(
                      child: EasyAutocomplete(
                          decoration:
                              const InputDecoration(hintText: "Chọn cấp độ"),
                          suggestions: const [
                            'Afeganistan',
                            'Albania',
                            'Algeria',
                            'Australia',
                            'Brazil',
                            'German',
                            'Madagascar',
                            'Mozambique',
                            'Portugal',
                            'Zambia'
                          ],
                          onChanged: (value) =>
                              print('onChanged value: $value'),
                          onSubmitted: (value) =>
                              print('onSubmitted value: $value')))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: EasyAutocomplete(
                          decoration:
                              const InputDecoration(hintText: "Chọn danh mục"),
                          suggestions: const [
                            'Afeganistan',
                            'Albania',
                            'Algeria',
                            'Australia',
                            'Brazil',
                            'German',
                            'Madagascar',
                            'Mozambique',
                            'Portugal',
                            'Zambia'
                          ],
                          onChanged: (value) =>
                              print('onChanged value: $value'),
                          onSubmitted: (value) =>
                              print('onSubmitted value: $value'))),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Expanded(
                      child: EasyAutocomplete(
                          decoration:
                              const InputDecoration(hintText: "Xắp xếp theo"),
                          suggestions: const [
                            'Afeganistan',
                            'Albania',
                            'Algeria',
                            'Australia',
                            'Brazil',
                            'German',
                            'Madagascar',
                            'Mozambique',
                            'Portugal',
                            'Zambia'
                          ],
                          onChanged: (value) =>
                              print('onChanged value: $value'),
                          onSubmitted: (value) =>
                              print('onSubmitted value: $value')))
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              DefaultTabController(
                  length: 3,
                  child: SizedBox(
                    height: 500,
                    child: Scaffold(
                        appBar: TabBar(
                          labelColor: Colors.black87,
                          tabs: const [
                            Tab(child: Text("Khóa học")),
                            Tab(child: Text("Ebooking")),
                            Tab(
                              child: Text("Interactive"),
                            ),
                          ],
                          onTap: (index) {
                            if (index == 2) {
                              _getInteractive();
                            } else if (index == 1) {
                              _getEbook();
                            } else {
                              _getCourse();
                            }
                          },
                        ),
                        body: TabBarView(
                          children: [
                            SingleChildScrollView(
                                child: Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: objects.isNotEmpty
                                    ? objects.map((object) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/course-info",
                                                arguments: object);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                                color: Colors.white),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 20),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          object["imageUrl"]),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20,
                                                          bottom: 20,
                                                          left: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        object["name"],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8)),
                                                      Text(
                                                          object["description"],
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          )),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 30)),
                                                      Text("Intermediate • "
                                                          "${object["topics"]!.length ?? 0}"
                                                          " Lessons")
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList()
                                    : [const Text("No data")],
                              ),
                            )),
                            SingleChildScrollView(
                                child: Container(
                              padding:
                                  EdgeInsets.only(top: 20, right: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: objects.isNotEmpty
                                    ? objects.map((object) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/course-info",
                                                arguments: object);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                                color: Colors.white),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 20),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          object["imageUrl"]),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 20,
                                                      bottom: 20,
                                                      left: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        object["name"],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8)),
                                                      Text(
                                                          object["description"],
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          )),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 30)),
                                                      Text("Intermediate • "
                                                          "${object["topics"]!.length ?? 0}"
                                                          " Lessons")
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList()
                                    : [Text("No data")],
                              ),
                            )),
                            SingleChildScrollView(
                                child: Container(
                              padding:
                                  EdgeInsets.only(top: 20, right: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: objects.isNotEmpty
                                    ? objects.map((object) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/course-info",
                                                arguments: object);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                                color: Colors.white),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 20),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          object["imageUrl"]),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 20,
                                                      bottom: 20,
                                                      left: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        object["name"],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8)),
                                                      Text(
                                                          object["description"],
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          )),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 30)),
                                                      Text("Intermediate • "
                                                          "${object["topics"]!.length ?? 0}"
                                                          " Lessons")
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList()
                                    : [Text("No data")],
                              ),
                            )),
                          ],
                        )),
                  )),
              const Padding(padding: EdgeInsets.only(top: 26)),
              NumberPaginator(
                numberPages: totalPage,
                onPageChange: (int index) {
                  setState(() {
                    currentPage = index;
                  });
                  _getCourse();
                },
              )
            ],
          ),
        ));
  }
}
