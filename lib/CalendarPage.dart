import 'package:easy_calendar/main.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/border/gf_border.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Easy Calendar'),),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: GFBorder(
                    color: themeColor.light.primary,
                    dashedLine: const [2, 0],
                    strokeWidth: 5,
                    type: GFBorderType.rRect,
                    radius: const Radius.circular(10),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GFListTile(
                          titleText: '일정',
                          subTitleText: '일정 테스트 입니다.',
                          icon: const Icon(Icons.access_time_filled),
                          color: themeColor.light.secondaryContainer,
                        ),
                        GFListTile(
                          titleText: '일정2',
                          subTitleText: '일정 테스트 입니다.',
                          icon: const Icon(Icons.access_time_filled),
                          color: themeColor.light.secondaryContainer,
                        ),
                        GFListTile(
                          titleText: '일정3',
                          subTitleText: '일정 테스트 입니다.',
                          icon: const Icon(Icons.access_time_filled),
                          color: themeColor.light.secondaryContainer,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: GFBorder(
                    color: themeColor.light.primary,
                    dashedLine: const [2, 0],
                    strokeWidth: 5,
                    type: GFBorderType.rRect,
                    radius: const Radius.circular(10),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GFListTile(
                          titleText: '일정',
                          subTitleText: '일정 테스트 입니다.',
                          icon: const Icon(Icons.access_time_filled),
                          color: themeColor.light.secondaryContainer,
                        ),
                        GFListTile(
                          titleText: '일정2',
                          subTitleText: '일정 테스트 입니다.',
                          icon: const Icon(Icons.access_time_filled),
                          color: themeColor.light.secondaryContainer,
                        ),
                        GFListTile(
                          titleText: '일정3',
                          subTitleText: '일정 테스트 입니다.',
                          icon: const Icon(Icons.access_time_filled),
                          color: themeColor.light.secondaryContainer,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: GFBorder(
                    color: themeColor.light.primary,
                    dashedLine: const [2, 0],
                    strokeWidth: 5,
                    type: GFBorderType.rRect,
                    radius: const Radius.circular(10),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GFListTile(
                          titleText: '일정',
                          subTitleText: '일정 테스트 입니다.',
                          icon: const Icon(Icons.access_time_filled),
                          color: themeColor.light.secondaryContainer,
                        ),
                        GFListTile(
                          titleText: '일정2',
                          subTitleText: '일정 테스트 입니다.',
                          icon: const Icon(Icons.access_time_filled),
                          color: themeColor.light.secondaryContainer,
                        ),
                        GFListTile(
                          titleText: '일정3',
                          subTitleText: '일정 테스트 입니다.',
                          icon: const Icon(Icons.access_time_filled),
                          color: themeColor.light.secondaryContainer,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}