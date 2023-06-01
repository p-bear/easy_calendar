import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_calendar/main_exception.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'main.dart';

class NetworkClient {
  final secureStorage = RootPage.secureStorage;

  static const loginPageUrl = 'https://p-bear.duckdns.org/auth/login-page.html';
  static const loginPageQueryParams = 'client_id=easyCalendar&redirect_uri=$targetAddress/auth.html';
  static const callbackUrlScheme = 'localhost';

  final googleAuthorizeUrl = 'https://accounts.google.com/o/oauth2/auth';
  final googleClientId = '358875882587-1lfij93q6g80hf4fdlnkkq0bjp2lehku.apps.googleusercontent.com';
  final googleRedirectUri = 'http://localhost:50001';
  final scope = 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/calendar';

  /*
   * authorization
   */

  Future<String> getMainAuthorizationToken() async {
    return await FlutterWebAuth.authenticate(
        url: '$loginPageUrl?$loginPageQueryParams',
        callbackUrlScheme: callbackUrlScheme);
  }

  Future<bool> oauthTokenGoogle() async {
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
      throw MainException.convert(e);
    }

    return true;
  }

  /*
   * easyCalendar APIs
   */

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

  /*
   * internal
   */

  Future<String> _getAccessToken() async {
    final accessToken = await secureStorage.read(key: appAccessTokenKey);
    if (accessToken == null) {
      throw Exception("no accessToken");
    }
    return accessToken;
  }
}