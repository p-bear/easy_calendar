import 'dart:collection';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

import 'main.dart';

class RestUtil {
  static const secureStorage = FlutterSecureStorage();

  Future<bool> checkToken() async {
    final accessToken = await _getAccessToken();

    try {
      await Dio().get(
              "$mainServerUrl/gateway/oauth/token/google",
              options: Options(
                  headers: {
                    "Authorization": "Bearer $accessToken"
                  }
              ),
          );
    } on DioError catch (e) {
      return false;
    }

    return true;
  }

  Future<String> getCalendarId() async {
    final accessToken = await _getAccessToken();

    Response<Map<String, dynamic>> response = await Dio().get(
      "$mainServerUrl/gateway/main/api/easyCalendar/calendarList",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken"
        }
      )
    );

    Map<String, dynamic>? resData = response.data;
    Map<String, dynamic> data = resData?["data"];
    List<dynamic> items = data["items"];
    String calendarId = "";
    for (Map<String, dynamic> item in items) {
      calendarId = item["id"];
      if (calendarId.contains("@gmail.com")) {
        break;
      }
    }
    return calendarId;
  }

  Future<List<dynamic>> getCalendarEvents(String calendarId) async {
    final accessToken = await _getAccessToken();

    Response<Map<String, dynamic>> response = await Dio().get(
        "$mainServerUrl/gateway/main/api/easyCalendar/calendars/$calendarId/events",
        options: Options(
            headers: {
              "Authorization": "Bearer $accessToken"
            }
        )
    );

    Map<String, dynamic>? resData = response.data;
    Map<String, dynamic> data = resData?["data"];
    List<dynamic> items = data["items"];
    return items;
  }

  Future<String> _getAccessToken() async {
    final accessToken = await secureStorage.read(key: appAccessTokenKey);
    if (accessToken == null) {
      throw Exception("no accessToken");
    }
    return accessToken;
  }
}