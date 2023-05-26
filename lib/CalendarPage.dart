import 'package:easy_calendar/main.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {

  void _toggleEventProperty() {

  }

  void _navigatePostTemplatePage() {

  }

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
                    child: SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GFButton(
                              onPressed: _toggleEventProperty,
                              text: "운동(WEEKDAY)",
                              size: GFSize.LARGE,
                              color: themeColor.dark.primaryContainer,
                              icon: const Icon(Icons.access_time, color: Colors.white70),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GFButton(
                              onPressed: _toggleEventProperty,
                              text: "운동(WEEKDAY)",
                              size: GFSize.LARGE,
                              color: themeColor.light.primaryContainer,
                              icon: const Icon(Icons.access_time, color: Colors.white70),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GFButton(
                              onPressed: _toggleEventProperty,
                              text: "운동(WEEKDAY)",
                              size: GFSize.LARGE,
                              color: themeColor.dark.primaryContainer,
                              icon: const Icon(Icons.access_time, color: Colors.white70),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: GFCard(
                              boxFit: BoxFit.cover,
                              color: themeColor.light.secondaryContainer,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              content: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: GFBorder(
                                        color: Colors.white,
                                        dashedLine: const [2, 0],
                                        type: GFBorderType.rRect,
                                        radius: const Radius.circular(20),
                                        strokeWidth: 7,
                                        child: Container(
                                          margin: const EdgeInsets.all(15),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                child: Text(
                                                  "이번주",
                                                  style: TextStyle(
                                                      color: themeColor.dark.primary,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      decoration: TextDecoration.underline
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Wrap(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                          onPressed: _toggleEventProperty,
                                                          text: "월요일",
                                                          size: GFSize.LARGE,
                                                          color: themeColor.dark.secondaryContainer
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "화요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "수요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "목요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "금요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "토요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "일요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                child: Text(
                                                  "다음주",
                                                  style: TextStyle(
                                                      color: themeColor.dark.primary,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      decoration: TextDecoration.underline
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Wrap(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                          onPressed: _toggleEventProperty,
                                                          text: "월요일",
                                                          size: GFSize.LARGE,
                                                          color: themeColor.dark.secondaryContainer
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "화요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "수요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "목요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "금요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "토요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                      child: GFButton(
                                                        onPressed: _toggleEventProperty,
                                                        text: "일요일",
                                                        size: GFSize.LARGE,
                                                        color: themeColor.dark.secondaryContainer,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: GFBorder(
                                        color: Colors.white,
                                        dashedLine: const [2, 0],
                                        type: GFBorderType.rRect,
                                        radius: const Radius.circular(20),
                                        strokeWidth: 7,
                                        child: Container(
                                          margin: EdgeInsets.all(15),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                child: Text(
                                                  "시간",
                                                  style: TextStyle(
                                                      color: themeColor.dark.primary,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      decoration: TextDecoration.underline
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                  child: GFButton(
                                                    onPressed: () {
                                                      Future<TimeOfDay?> selectedTime = showTimePicker(context: context, initialTime: TimeOfDay.now());
                                                      selectedTime.then((value) => null);
                                                    },
                                                    text: "Time",
                                                    size: GFSize.LARGE,
                                                    color: themeColor.dark.secondaryContainer,
                                                    icon: const Icon(Icons.access_time_filled, color: Colors.white,),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GFButton(
                              onPressed: _toggleEventProperty,
                              text: "운동(WEEKDAY)",
                              size: GFSize.LARGE,
                              color: themeColor.dark.primaryContainer,
                              icon: const Icon(Icons.access_time, color: Colors.white70),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GFButton(
                              onPressed: _toggleEventProperty,
                              text: "운동(WEEKDAY)",
                              size: GFSize.LARGE,
                              color: themeColor.dark.primaryContainer,
                              icon: const Icon(Icons.access_time, color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: GFButton(
                    onPressed: _navigatePostTemplatePage,
                    text: "일정 등록",
                    shape: GFButtonShape.pills,
                    fullWidthButton: true,
                    color: themeColor.dark.primaryContainer,
                    size: GFSize.LARGE,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}