import 'dart:collection';

import 'package:easy_calendar/main_exception.dart';
import 'package:easy_calendar/network_client.dart';
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
  final NetworkClient networkClient = NetworkClient();
  final secureStorage = RootPage.secureStorage;

  String _selectedCalendarId = "";
  String selectedType = "";
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  List<Map<String, dynamic>> templateList = [];
  List<Widget> templateListContainers = [];
  late Future<Widget> templateFuture;
  late int _selectedTemplateId;
  final List<String> _weekdayAllList = [
    "월요일",
    "화요일",
    "수요일",
    "목요일",
    "금요일",
    "토요일",
    "일요일",
  ];
  String _selectedWeek = "";
  String _selectedWeekday = "";

  @override
  void initState() {
    super.initState();
    _checkAuth();
    templateFuture = _createEventTemplateArea();
  }

  void _checkAuth() async {
    try {
      await networkClient.getOauthTokenGoogle();
    } on MainException catch (e) {
      if (e.code.startsWith("google")) {
        String responseUri = await networkClient.getGoogleAuthorizationCode();
        String? code = Uri.parse(responseUri).queryParameters['code'];
        await networkClient.postOauthTokenGoogle(code!);
        _returnToMainState();
        return;
      }
      RootPage.secureStorage.delete(key: appAccessTokenKey);
      _returnToMainState();
    }
  }

  void _returnToMainState() {
    Navigator.popAndPushNamed(context, "/");
  }

  Future<List<Widget>> _createCalendarEvent() async {
    _selectedCalendarId = await networkClient.getCalendarId();
    List<dynamic> res = await networkClient.getCalendarEvents(_selectedCalendarId);
    res.sort((a, b) => _compareStartTime(a, b));
    final targetEvents = res.sublist(0, 4);
    for (Map<String, dynamic> event in targetEvents) {
      Map<String, String> start = Map.from(event["start"]);
      _addCalendarEvent(event["id"], start["dateTime"]!, event["summary"]);
    }

    return eventList.values.toList();
  }

  Future<List<Widget>> _createPostTemplateArea() async {
    List<Widget> widgetList = [];

    List<String> templateTypeList = await networkClient.getTemplateType();
    selectedType = templateTypeList[0];

    widgetList.add(Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: GFDropdown(
        items: templateTypeList
            .map((type) => DropdownMenuItem(child: Text(type)))
            .toList(),
        onChanged: (newVal) {
          setState(() {
            if (newVal != null) {
              selectedType = newVal;
            }
          });
        },
      ),
    ));

    widgetList.add(Wrap(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: GFTextField(
            controller: _titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "버튼 타이틀",
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: TextField(
            controller: _summaryController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "이벤트 이름",
            ),
          ),
        ),
      ],
    ));

    widgetList.add(Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: GFButton(
        onPressed: _postTemplate,
        text: "일정 등록",
        shape: GFButtonShape.pills,
        fullWidthButton: true,
        color: themeColor.dark.primaryContainer,
        size: GFSize.LARGE,
      ),
    ));
    return widgetList;
  }

  _postTemplate() async {
    networkClient.postTemplate(
        _titleController.text, _summaryController.text, selectedType);
  }

  int _compareStartTime(Map<String, dynamic> a, Map<String, dynamic> b) {
    Map<String, String> aStart = Map.from(a["start"]);
    DateTime aTime = DateTime.parse(aStart["dateTime"]!);
    Map<String, String> bStart = Map.from(b["start"]);
    DateTime bTime = DateTime.parse(bStart["dateTime"]!);
    return aTime.difference(bTime).inSeconds;
  }

  _addCalendarEvent(String eventId, String title, String subtitle) {
    eventList[eventId] = _createEventTile(UniqueKey(), title, subtitle);
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

  Future<Widget> _createEventTemplateArea() async {
    List<dynamic> responseData = await networkClient.getTemplateList();
    templateList = responseData.map((e) {
      return e as Map<String, dynamic>;
    }).toList();
    for (var element in templateList) {
      element["selected"] = false;
    }

    templateListContainers = _createTemplateListContainers();
    return Wrap(
      children: templateListContainers,
    );
  }

  List<Widget> _createTemplateListContainers() {
    return templateList.map((template) {
      return Container(
        key: UniqueKey(),
        margin: const EdgeInsets.all(10),
        child: GFButton(
          key: UniqueKey(),
          onPressed: () {
            _insertEventProperty(template["id"] as int);
          },
          text: "${template["title"]}(${template["type"]})",
          size: GFSize.LARGE,
          color: template["selected"] == true
              ? themeColor.light.primaryContainer
              : themeColor.dark.primaryContainer,
          icon: const Icon(Icons.access_time, color: Colors.white70),
        ),
      );
    }).toList();
  }

  _insertEventProperty(int id) {
    setState(() {
      _selectedTemplateId = id;

      var selectedTemplate;
      for (var element in templateList) {
        if (element["id"] == id) {
          selectedTemplate = element;
          element["selected"] = true;
        } else {
          element["selected"] = false;
        }
      }

      List<Widget> templateContainers = _createTemplateListContainers();

      templateContainers.insert(
          templateList.indexOf(selectedTemplate) + 1,
          Container(
            key: UniqueKey(),
            margin: const EdgeInsets.all(10),
            child: _createTemplateDetails(selectedTemplate["type"]),
          ));

      templateFuture = Future(() {
        return Wrap(children: templateContainers);
      });
    });
  }

  Widget _createTemplateDetails(String type) {
    if (type == "WEEKDAY") {
      List<Widget> currentWeekButtonList = [];
      List<Widget> nextWeekButtonList = [];
      for (String weekday in _weekdayAllList) {
        currentWeekButtonList.add(_createWeekdayButton("이번주", weekday));
        nextWeekButtonList.add(_createWeekdayButton("다음주", weekday));
      }

      return SizedBox(
        width: double.infinity,
        child: GFCard(
          boxFit: BoxFit.cover,
          color: themeColor.light.secondaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              children: currentWeekButtonList,
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
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              children: nextWeekButtonList,
                            ),
                          ),
                        ],
                      ),
                    )),
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
                      margin: const EdgeInsets.all(15),
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
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                              child: GFButton(
                                onPressed: () {
                                  if (_selectedWeek.isEmpty || _selectedWeekday.isEmpty) {
                                    _showSelectWeekdayWarningAlert();
                                    return;
                                  }
                                  Future<TimeOfDay?> selectedTime =
                                      showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                  selectedTime.then((value) => _postCalendarEvents(value));
                                },
                                text: "Time",
                                size: GFSize.LARGE,
                                color: themeColor.dark.secondaryContainer,
                                icon: const Icon(
                                  Icons.access_time_filled,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
    } else {
      return Text("fail to validate type: $type");
    }
  }

  Widget _createWeekdayButton(String week, String weekday) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: GFButton(
          onPressed: () {
            _setWeekDay(week, weekday);
          },
          text: weekday,
          size: GFSize.LARGE,
          color: week == _selectedWeek && weekday == _selectedWeekday
              ? themeColor.light.primaryContainer
              : themeColor.dark.secondaryContainer),
    );
  }

  _setWeekDay(String week, String weekday) {
    _selectedWeek = week;
    _selectedWeekday = weekday;
    setState(() {
      _insertEventProperty(_selectedTemplateId);
    });
  }

  _showSelectWeekdayWarningAlert() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GFAlert(
          type: GFAlertType.rounded,
          title: "경고",
          subtitle: "요일을 선택해야 합니다.",
          bottomBar: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GFButton(
                  text: "확인",
                  size: GFSize.LARGE,
                  color: themeColor.dark.primaryContainer,
                  onPressed: () => Navigator.of(context).pop())
            ],
          ),
        );
      },
    );
  }

  _showPostEventSuccessAlert() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GFAlert(
          type: GFAlertType.rounded,
          title: "성공",
          subtitle: "이벤트 등록에 성공했습니다!!",
          bottomBar: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GFButton(
                  text: "확인",
                  size: GFSize.LARGE,
                  color: themeColor.dark.primaryContainer,
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/calendar");
                  })
            ],
          ),
        );
      },
    );
  }

  _postCalendarEvents(TimeOfDay? selectedTime) async {
    if (selectedTime == null) {
      return;
    }
    Map<String, dynamic> template = templateList.firstWhere((element) => element["id"] == _selectedTemplateId);

    await networkClient.postCalendarEvents(
      _selectedCalendarId,
      template["summary"],
      "${_calcDate(_selectedWeek, _selectedWeekday)}T${selectedTime.hour.toString().padLeft(2, '0')}:00:00+09:00",
      "${_calcDate(_selectedWeek, _selectedWeekday)}T${(selectedTime.hour + 1).toString().padLeft(2, '0')}:00:00+09:00",);

    await _showPostEventSuccessAlert();
  }

  String _calcDate(String week, String weekday) {
    DateTime today = DateTime.now();
    int todayWeekIndex = today.weekday == 0 ? 6 : today.weekday - 1;
    int selectedWeekdayIndex = _weekdayAllList.indexOf(weekday);
    int weekdayDiffer = selectedWeekdayIndex - todayWeekIndex;
    today = today.add(Duration(days: weekdayDiffer));

    if (week == "다음주") {
      today = today.add(const Duration(days: 7));
    }

    return "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Calendar'),
      ),
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
                    child: FutureBuilder(
                      future: _createCalendarEvent(),
                      initialData: const [Text("data loading 중")],
                      builder: (context, snapshot) {
                        return Column(
                          key: UniqueKey(),
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: snapshot.requireData,
                        );
                      },
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
                        child: FutureBuilder(
                          future: templateFuture,
                          initialData: const Text("loading 중"),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data!;
                            } else {
                              return const Text("loading 중");
                            }
                          },
                        ),
                      )),
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
                    child: FutureBuilder(
                      future: _createPostTemplateArea(),
                      initialData: const [Text("data loading 중")],
                      builder: (context, snapshot) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: snapshot.requireData);
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
