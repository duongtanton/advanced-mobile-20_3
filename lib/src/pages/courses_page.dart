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
                    const Row(
                      children: [
                        Icon(
                          CupertinoIcons.upload_circle,
                          size: 90,
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
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, "/course-info");
                                },
                                child: const Icon(Icons.directions_transit),
                              ),
                              GestureDetector(
                                child: const Icon(Icons.directions_transit),
                              ),
                              GestureDetector(
                                child: const Icon(Icons.directions_bike),
                              ),
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
