import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_20120598/src/constants/country.dart';
import 'package:mobile_20120598/src/pages/booking_page.dart';
import 'package:mobile_20120598/src/pages/course_info_page.dart';
import 'package:mobile_20120598/src/pages/courses_page.dart';
import 'package:mobile_20120598/src/pages/error_page.dart';
import 'package:mobile_20120598/src/pages/evaluate_page.dart';
import 'package:mobile_20120598/src/pages/home_page.dart';
import 'package:mobile_20120598/src/pages/lesson_info.dart';
import 'package:mobile_20120598/src/pages/schedule_page.dart';
import 'package:mobile_20120598/src/pages/signin_page.dart';
import 'package:mobile_20120598/src/pages/signup_page.dart';
import 'package:mobile_20120598/src/pages/video_call_page.dart';

Future main() async {
  const environment =
      String.fromEnvironment('FLAVOR', defaultValue: 'development');
  await dotenv.load(fileName: '.env.$environment');
  await CountryService.loadCountries();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '20120598',
      initialRoute: "/sign-in",
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => const HomePage(title: ""));
          case '/sign-in':
            return MaterialPageRoute(
                builder: (context) => const SignInPage(title: "sign-in"));
          case '/sign-up':
            return MaterialPageRoute(
                builder: (context) => const SignUpPagePage(title: "sign-up"));
          case '/booking':
            return MaterialPageRoute(
                builder: (context) => const BookingPage(title: "booking"));
          case '/schedule':
            return MaterialPageRoute(
                builder: (context) => const SchedulePage(title: "schedule"));
          case '/evaluate':
            return MaterialPageRoute(
                builder: (context) => const EvaluatePage(title: "evaluate"));
          case '/courses':
            return MaterialPageRoute(
                builder: (context) => const CoursesPage(title: "courses"));
          case '/course-info':
            return MaterialPageRoute(
                builder: (context) =>
                    const CourseInfoPage(title: "course-info"));
          case '/lesson-info':
            return MaterialPageRoute(
                builder: (context) =>
                    const LessonInfoPage(title: "lesson-info"));
          case '/video-call':
            return MaterialPageRoute(
                builder: (context) => const VideoCallPage(title: "video-call"));
          default:
            // Handle unknown routes here
            return MaterialPageRoute(
                builder: (context) => const ErrorPage(title: "\\error"));
        }
      },
    );
  }
}
