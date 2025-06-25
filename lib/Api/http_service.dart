import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:invoicer_pro_flutter/Api/repository/logout_repository.dart';
import 'package:invoicer_pro_flutter/main.dart';
import 'package:invoicer_pro_flutter/utils/custom_snack_bar.dart';
import 'package:invoicer_pro_flutter/utils/other.dart';
import 'package:invoicer_pro_flutter/utils/shared_preference/pref_key.dart';

import '../router/routing_constants.dart';
import '../utils/custom_exception.dart';
import '../utils/internet_connection_helper.dart';
import '../utils/shared_preference/shared_pref.dart';

class HttpService {
  // //live url
  static const baseUrl = "http://192.168.1.10:8080";

  late Dio _dio;

  HttpService({String baseUrl = baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: const Duration(seconds: 60),
        // 15 seconds
        connectTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      ),
    );

    initializeInterceptors();
  }

  Future<Response> postRequest(String endPoint, dynamic map) async {
    Response response;

    try {
      // Add this condition to avoid recursion
      // before passing jwt token check expiry

      String jwtToken = "";
      jwtToken =
          await SharedPref.getString(PrefKey.jwtAccessToken, defaultValue: "");

      // We pass the authentication token in header
      _dio.options.contentType = Headers.formUrlEncodedContentType;
      if (!jwtToken.isNullOrEmpty()) {
        _dio.options.headers['Content-Type'] = 'application/json';
        _dio.options.headers["Authorization"] = "Bearer $jwtToken";
      }

      response = await _dio.post(endPoint, data: map);
    } on CustomException catch (e) {
      debugPrint(e.cause);
      throw CustomException(e.cause ?? '');
    }
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          log("response=>${jsonEncode(response.data)}");
          final serverResponse = jsonDecode(jsonEncode(response.data));
          if (serverResponse["status_code"] == "404") {
            logoutAPI();
          }

          return handler.next(response);
        },
        onRequest: (options, handler) {
          log("${options.uri}\n${options.data}");

          if (options.data is FormData) {
            var data = options.data as FormData;
            log("${data.fields}\n\n");
            // debugPrint("${data.files}\n\n");
          }
          return handler.next(options); //continue
        },
        onError: (error, handler) {
          log(error.message ?? '');
          return handler.next(error); //continue
        },
      ),
    );
  }

  Future<void> logoutAPI() async {
    try {
      if (await isConnected(navigatorKey.currentContext!)) {
        await LogoutRepository().logoutApi().then(
          (value) async {
            if (value.statusCode == "1") {
              // await ChatHelper().logoutUser();
              await SharedPref.resetPreferences();

              FirebaseMessaging.instance.getToken().then(
                (firebaseResponse) {
                  if (!firebaseResponse.isNullOrEmpty()) {
                    SharedPref.setString(
                        PrefKey.fcmToken, firebaseResponse.toString());

                    Navigator.pushNamedAndRemoveUntil(
                        navigatorKey.currentContext!,
                        loginScreenRoute,
                        (route) => false);
                  }
                },
              );
            }
          },
        );
      }
    } on CustomException catch (e) {
      showSnackBarRed(navigatorKey.currentContext!, e.cause);
    }
  }
}
