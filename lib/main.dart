import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_20120598/src/bloc/Lang.dart';
import 'package:mobile_20120598/src/constants/common.dart';
import 'package:mobile_20120598/src/pages/become_tutor.dart';
import 'package:mobile_20120598/src/pages/booking_page.dart';
import 'package:mobile_20120598/src/pages/course_info_page.dart';
import 'package:mobile_20120598/src/pages/courses_page.dart';
import 'package:mobile_20120598/src/pages/error_page.dart';
import 'package:mobile_20120598/src/pages/evaluate_page.dart';
import 'package:mobile_20120598/src/pages/home_page.dart';
import 'package:mobile_20120598/src/pages/lesson_info_page.dart';
import 'package:mobile_20120598/src/pages/schedule_page.dart';
import 'package:mobile_20120598/src/pages/signin_page.dart';
import 'package:mobile_20120598/src/pages/signup_page.dart';
import 'package:mobile_20120598/src/pages/user_page.dart';
import 'package:mobile_20120598/src/pages/video_call_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

Future main() async {
  const environment =
      String.fromEnvironment('FLAVOR', defaultValue: 'development');
  await dotenv.load(fileName: '.env.$environment');
  await CommonConstant.loadCountries();
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.prefs});

  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '20120598',
        initialRoute: "/sign-in",
        themeMode: ThemeMode.system,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) {
                          String lang = prefs.getString('lang') ?? 'vi';
                          String theme = prefs.getString('theme') ?? 'light';
                          return GlobalStateCubit(lang, theme);
                        },
                        child: const HomePage(title: ""),
                      ),
                  settings: settings);
            case '/sign-in':
              return MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) {
                          String lang = prefs.getString('lang') ?? 'vi';
                          String theme = prefs.getString('theme') ?? 'light';
                          return GlobalStateCubit(lang, theme);
                        },
                        child: const SignInPage(title: "sign-in"),
                      ),
                  settings: settings);
            case '/sign-up':
              return MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) {
                          String lang = prefs.getString('lang') ?? 'vi';
                          String theme = prefs.getString('theme') ?? 'light';
                          return GlobalStateCubit(lang, theme);
                        },
                        child: const SignUpPagePage(title: "sign-up"),
                      ),
                  settings: settings);
            case '/booking':
              return MaterialPageRoute(
                  builder: (context) {
                    String lang = prefs.getString('lang') ?? 'vi';
                    String theme = prefs.getString('theme') ?? 'light';
                    return BlocProvider(
                      create: (context) => GlobalStateCubit(lang, theme),
                      child: const BookingPage(title: "booking"),
                    );
                  },
                  settings: settings);
            case '/schedule':
              return MaterialPageRoute(
                  builder: (context) {
                    String lang = prefs.getString('lang') ?? 'vi';
                    String theme = prefs.getString('theme') ?? 'light';
                    return BlocProvider(
                      create: (context) => GlobalStateCubit(lang, theme),
                      child: const SchedulePage(title: "schedule"),
                    );
                  },
                  settings: settings);
            case '/evaluate':
              return MaterialPageRoute(
                  builder: (context) {
                    String lang = prefs.getString('lang') ?? 'vi';
                    String theme = prefs.getString('theme') ?? 'light';
                    return BlocProvider(
                      create: (context) => GlobalStateCubit(lang, theme),
                      child: const EvaluatePage(title: "evaluate"),
                    );
                  },
                  settings: settings);
            case '/courses':
              return MaterialPageRoute(
                  builder: (context) {
                    String lang = prefs.getString('lang') ?? 'vi';
                    String theme = prefs.getString('theme') ?? 'light';
                    return BlocProvider(
                      create: (context) => GlobalStateCubit(lang, theme),
                      child: const CoursesPage(title: "courses"),
                    );
                  },
                  settings: settings);
            case '/course-info':
              return MaterialPageRoute(
                  builder: (context) {
                    String lang = prefs.getString('lang') ?? 'vi';
                    String theme = prefs.getString('theme') ?? 'light';
                    return BlocProvider(
                      create: (context) => GlobalStateCubit(lang, theme),
                      child: const CourseInfoPage(title: "course-info"),
                    );
                  },
                  settings: settings);
            case '/lesson-info':
              return MaterialPageRoute(
                  builder: (context) {
                    String lang = prefs.getString('lang') ?? 'vi';
                    String theme = prefs.getString('theme') ?? 'light';
                    return BlocProvider(
                      create: (context) => GlobalStateCubit(lang, theme),
                      child: const LessonInfoPage(title: "lesson-info"),
                    );
                  },
                  settings: settings);
            case '/video-call':
              return MaterialPageRoute(
                  builder: (context) {
                    String lang = prefs.getString('lang') ?? 'vi';
                    String theme = prefs.getString('theme') ?? 'light';
                    return BlocProvider(
                      create: (context) => GlobalStateCubit(lang,  theme),
                      child: const VideoCallPage(title: "video-call"),
                    );
                  },
                  settings: settings);
            case '/user':
              return MaterialPageRoute(
                  builder: (context) {
                    String lang = prefs.getString('lang') ?? 'vi';
                    String theme = prefs.getString('theme') ?? 'light';
                    return BlocProvider(
                      create: (context) => GlobalStateCubit(lang, theme),
                      child: const UserPage(title: "user"),
                    );
                  },
                  settings: settings);
            case '/become-tutor':
              return MaterialPageRoute(
                  builder: (context) {
                    String lang = prefs.getString('lang') ?? 'vi';
                    String theme = prefs.getString('theme') ?? 'light';
                    return BlocProvider(
                      create: (context) => GlobalStateCubit(lang, theme),
                      child: const BecomeTutorPage(title: "become-tutor"),
                    );
                  },
                  settings: settings);
            default:
              // Handle unknown routes here
              return MaterialPageRoute(
                  builder: (context) {
                    String lang = prefs.getString('lang') ?? 'vi';
                    String theme = prefs.getString('theme') ?? 'light';
                    return BlocProvider(
                      create: (context) => GlobalStateCubit(lang, theme),
                      child: const ErrorPage(title: "error"),
                    );
                  },
                  settings: settings);
          }
        },
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('vi', 'VN'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ]);
  }
}
