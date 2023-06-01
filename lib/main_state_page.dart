
import 'package:easy_calendar/main.dart';
import 'package:easy_calendar/network_client.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';


class MainStatePage extends StatefulWidget {
  const MainStatePage({super.key});

  @override
  State<StatefulWidget> createState() => MainSate();
}

class MainSate extends State<MainStatePage> {
  final secureStorage = RootPage.secureStorage;
  final networkClient = NetworkClient();

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
    final result = await networkClient.getMainAuthorizationToken();
    var accessToken = Uri.parse(result).queryParameters['access_token'];
    secureStorage.write(key: appAccessTokenKey, value: accessToken);
    _navCalendarPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Easy Calendar'),),
      body: const NeedLoginPage(),
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