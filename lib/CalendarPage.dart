import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:easy_calendar/RestUtil.dart';
import 'package:easy_calendar/main.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  final Map<String, GFListTile> eventList = HashMap();
  final RestUtil restUtil = RestUtil();

  @override
  void initState() {
    super.initState();
    _checkToken();
    _initCalendarEvent();
  }

  void _checkToken() async {
    try {
      bool result = await restUtil.checkToken();
      if (!result) {
        _returnToMainState();
      }
    } on DioError {
      _returnToMainState();
    }
  }

  void _returnToMainState() {
    RestUtil.secureStorage.delete(key: appAccessTokenKey);
    Navigator.popAndPushNamed(context, "/");
  }

  void _toggleEventProperty() {

  }

  void _navigatePostTemplatePage() {

  }

  List<Widget> _createCalendarEvent() {
    return eventList.values.toList();
  }

  _initCalendarEvent() async {
    String calendarId = await restUtil.getCalendarId();
    List<dynamic> res = await restUtil.getCalendarEvents(calendarId);
    res.sort((a, b) => _compareStartTime(a, b));
    final targetEvents = res.sublist(0, 4);
    for (Map<String, dynamic> event in targetEvents) {
      Map<String, String> start = Map.from(event["start"]);
      _addCalendarEvent(event["id"], start["dateTime"]!, event["summary"]);
    }
  }

  int _compareStartTime(Map<String, dynamic> a, Map<String, dynamic> b) {
    Map<String, String> aStart = Map.from(a["start"]);
    DateTime aTime = DateTime.parse(aStart["dateTime"]!);
    Map<String, String> bStart = Map.from(b["start"]);
    DateTime bTime = DateTime.parse(bStart["dateTime"]!);;
    return aTime.difference(bTime).inSeconds;
  }

  _addCalendarEvent(String eventId, String title, String subtitle) {
    if (mounted) {
      setState(() {
        eventList[eventId] = _createEventTile(UniqueKey(), title, subtitle);
      });
    }
  }

  void _deleteCalendarEvent() async {
    setState(() {
      eventList.remove("1");
    });
  }

  GFListTile _createEventTile(Key key, String title, String subtitle) {
    return GFListTile(
      key: key,
      titleText: title,
      subTitleText: subtitle,
      icon: const Icon(Icons.access_time_filled),
      color: themeColor.light.secondaryContainer,
    );
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
                      children: _createCalendarEvent(),
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
                    // onPressed: _navigatePostTemplatePage,
                    onPressed: _deleteCalendarEvent,
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