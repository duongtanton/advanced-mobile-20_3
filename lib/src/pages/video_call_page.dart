import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/layouts/main_layout.dart';
import 'package:number_paginator/number_paginator.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key, required this.title});

  final String title;

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        screen: "vide_call_page",
        showNavigators: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NumberPaginator(
              numberPages: 10,
              onPageChange: (int index) {
                // handle page change...
                Navigator.pushNamed(context, "/");
              },
            )
          ],
        ));
  }
}
