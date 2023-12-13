import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/components/header.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key, required this.title});

  final String title;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
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
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 40, bottom: 40),
                      child: [
                        const Text(
                          "Opps",
                          style: TextStyle(
                              fontSize: 100, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Something went wrong",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        const Text(
                          "The page you are looking for might have been removed had its name changed or is temporarily unavailable.",
                          style: TextStyle(fontSize: 20),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/"),
                          child: const Text("Back to home"),
                        )
                      ].elementAt(0))))
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
