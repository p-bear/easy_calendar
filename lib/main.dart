import 'package:easy_calendar/CalendarPage.dart';
import 'package:easy_calendar/MainStatePage.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

const String mainServerUrl = "https://p-bear.duckdns.org";
const String targetAddress = "http://localhost:50001";
const appAccessTokenKey = 'easyCalendarAccessToken';
const FlexScheme flexScheme = FlexScheme.deepBlue;
const FlexSchemeData themeColor = FlexColor.deepBlue;

void main() {
  runApp(const RootPage());
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

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