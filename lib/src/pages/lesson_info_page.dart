import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:number_paginator/number_paginator.dart';

class LessonInfoPage extends StatefulWidget {
  const LessonInfoPage({super.key, required this.title});

  final String title;

  @override
  State<LessonInfoPage> createState() => _LessonInfoPageState();
}

class _LessonInfoPageState extends State<LessonInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        screen: "lesson_info_page",
        showNavigators: true,
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NumberPaginator(
              numberPages: 10,
              onPageChange: (int index) {
                // handle page change...
                Navigator.pushNamed(context, "/video-call");
              },
            )
          ],
        ));
  }
}
