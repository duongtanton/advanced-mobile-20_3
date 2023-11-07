import 'package:flutter/material.dart';
import 'package:mobile_20120598/src/pages/booking_page.dart';
import 'package:mobile_20120598/src/pages/course_info_page.dart';
import 'package:mobile_20120598/src/pages/courses_page.dart';
import 'package:mobile_20120598/src/pages/evaluate_page.dart';
import 'package:mobile_20120598/src/pages/home_page.dart';
import 'package:mobile_20120598/src/pages/schedule_page.dart';
import 'package:mobile_20120598/src/pages/signin_page.dart';
import 'package:mobile_20120598/src/pages/video_call_page.dart';

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
        '/schedule': (context) => const SchedulePage(title: "LetTuTor"),
        '/evaluate': (context) => const EvaluatePage(title: "LetTuTor"),
        '/courses': (context) => const CoursesPage(title: "LetTuTor"),
        '/course-info': (context) => const CourseInfoPage(title: "LetTuTor"),
        '/video-call': (context) => const VideoCallPage(title: "LetTuTor"),
      },
    );
  }
}

