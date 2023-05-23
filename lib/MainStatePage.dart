
import 'package:easy_calendar/CalendarPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainStatePage extends StatefulWidget {
  const MainStatePage({super.key});

  @override
  State<StatefulWidget> createState() => _MainSate();
}

class _MainSate extends State<MainStatePage> {
  static const secureStorage = FlutterSecureStorage();
  static const String appAccessTokenKey = 'appAccessToken';


  @override
  void initState() {
    super.initState();

    _checkLogin();
  }

  Future<bool> _checkLogin() {
    return secureStorage.containsKey(key: appAccessTokenKey);
  }

  @override
  Widget build(BuildContext context) {
    return const MainScaffold();
  }
}

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Easy Calendar'),),
      body: const CalendarPage(),
    );
  }
}