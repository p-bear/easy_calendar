
import 'package:easy_calendar/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:getwidget/getwidget.dart';


class MainStatePage extends StatefulWidget {
  const MainStatePage({super.key});

  @override
  State<StatefulWidget> createState() => MainSate();
}

class MainSate extends State<MainStatePage> {
  static const secureStorage = FlutterSecureStorage();

  static const loginPageUrl = 'https://p-bear.duckdns.org/auth/login-page.html';
  static const loginPageQueryParams = 'client_id=easyCalendar&redirect_uri=$targetAddress/auth.html';
  static const callbackUrlScheme = 'localhost';

  Widget _body = const NeedLoginPage();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  _checkLogin() {
    // secureStorage 에 토큰이 있는지 확인
    return secureStorage.containsKey(key: appAccessTokenKey).then((value) => {
      if (value) {
        // 켈린더 페이지 띄우기
        _navCalendarPage()
      } else {
        // 로그인 창 띄우기
        popLoginPage()
      }
    });
  }

  void _navCalendarPage() {
    Navigator.popAndPushNamed(context, '/calendar');
  }

  void popLoginPage() async {
    setState(() {
      _body = const NeedLoginPage();
    });

    final result = await FlutterWebAuth.authenticate(
        url: '$loginPageUrl?$loginPageQueryParams',
        callbackUrlScheme: callbackUrlScheme);

    var accessToken = Uri.parse(result).queryParameters['access_token'];
    secureStorage.write(key: appAccessTokenKey, value: accessToken);
    _navCalendarPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Easy Calendar'),),
      body: _body,
    );
  }
}

class NeedLoginPage extends StatelessWidget {
  const NeedLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const GFLoader(type: GFLoaderType.ios,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: GFBorder(
                dashedLine: const [2, 0],
                strokeWidth: 4,
                type: GFBorderType.rect,
                child: const Text('알림: 로그인이 필요합니다.'),
            ),
          ),
        ],
      ),
    );
  }
}