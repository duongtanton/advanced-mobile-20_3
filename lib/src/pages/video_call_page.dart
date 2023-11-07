import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/components/header.dart';
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
                        NumberPaginator(
                          numberPages: 10,
                          onPageChange: (int index) {
                            // handle page change...
                            Navigator.pushNamed(context, "/");
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
