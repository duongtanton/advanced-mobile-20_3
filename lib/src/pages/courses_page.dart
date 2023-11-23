import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/components/header.dart';
import 'package:number_paginator/number_paginator.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key, required this.title});

  final String title;

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  void initState() {
    super.initState();
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
                const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 40),
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
                            Navigator.popAndPushNamed(context, "/course-info");
                          },
                          child: Icon(
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
                                text:
                                    "LiveTutor đã xây dựng nên các khóa học của các lĩnh vực trong cuộc sống chất lượng, bài bản và khoa học nhất cho những người đang có nhu cầu trau dồi thêm kiến thức về các lĩnh vực.")),
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
                            decoration: const InputDecoration(
                                hintText: "Chọn danh mục"),
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
                          appBar: const TabBar(
                            labelColor: Colors.black87,
                            tabs: [
                              Tab(icon: Icon(Icons.directions_car)),
                              Tab(icon: Icon(Icons.directions_transit)),
                              Tab(icon: Icon(Icons.directions_bike)),
                            ],
                          ),
                          body: TabBarView(
                            children: [
                              SingleChildScrollView(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    top: 20, right: 20, left: 20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 30)),
                                    Text("English for traveling",
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              SingleChildScrollView(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    top: 20, right: 20, left: 20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 30)),
                                    Text("English for traveling",
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              SingleChildScrollView(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    top: 20, right: 20, left: 20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 30)),
                                    Text("English for traveling",
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Life in the internet Age",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8)),
                                                Text(
                                                    "Let's discuss how technology is changing the way we live",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 30)),
                                                Text("Intermediate • 9 Lessons")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          )),
                    )),
                const Padding(padding: EdgeInsets.only(top: 26)),
                NumberPaginator(
                  numberPages: 10,
                  onPageChange: (int index) {
                    // handle page change...
                  },
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
