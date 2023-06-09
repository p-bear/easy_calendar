import 'package:easy_calendar/calendar_page.dart';
import 'package:easy_calendar/main_state_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String mainServerUrl = "https://p-bear.duckdns.org";
// const String targetAddress = "http://localhost:50001";
const String targetAddress = "https://p-bear.duckdns.org/easycal";
const appAccessTokenKey = 'easyCalendarAccessToken';
const FlexScheme flexScheme = FlexScheme.deepBlue;
const FlexSchemeData themeColor = FlexColor.deepBlue;

void main() {
  runApp(const RootPage());
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});
  static const secureStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Calendar',
      theme: FlexThemeData.light(scheme: flexScheme),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainStatePage(),
        '/calendar': (context) => const CalendarPage(),
      },
    );
  }
}