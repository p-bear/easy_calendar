import 'package:easy_calendar/CalendarPage.dart';
import 'package:easy_calendar/MainStatePage.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

const String targetAddress = "http://localhost:50001";
const appAccessTokenKey = 'easyCalendarAccessToken';
const themeColor = FlexColor.aquaBlue;

void main() {
  runApp(const RootPage());
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Calendar',
      theme: FlexThemeData.light(scheme: FlexScheme.aquaBlue),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainStatePage(),
        '/calendar': (context) => const CalendarPage(),
      },
    );
  }
}