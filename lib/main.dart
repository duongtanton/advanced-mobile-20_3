import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/pages/booking_page.dart';
import 'package:mobile_20120598/src/pages/home_page.dart';
import 'package:mobile_20120598/src/pages/signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '20120598',
      initialRoute: "/sign-in",
      routes: {
        '/': (context) => const HomePage(title: "Home"),
        '/sign-in': (context) => const SignInPage(title: "LetTuTor"),
        '/booking': (context) => const BookingPage(title: "LetTuTor"),
      },
    );
  }
}

