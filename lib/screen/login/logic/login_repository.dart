import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:invoicer_pro_flutter/Api/api_endpoints.dart';
import 'package:invoicer_pro_flutter/Api/http_service.dart';

class LoginRepository {
  Future<void> callLoginApi(Map<String, dynamic> loginMap) async {
    Response loginResponse =
        await HttpService().postRequest(ApiEndpoints.loginEndPoint, loginMap);

    if (loginResponse.statusCode == 200) {
      log(loginResponse.toString());
    }
  }
}
