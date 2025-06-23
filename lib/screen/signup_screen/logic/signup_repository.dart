import 'package:dio/dio.dart';
import 'package:invoicer_pro_flutter/Api/api_endpoints.dart';
import 'package:invoicer_pro_flutter/Api/http_service.dart';
import 'package:invoicer_pro_flutter/utils/custom_exception.dart';

class SignupRepository {
  Future<void> callSignupApi(Map<String, dynamic> signupMap) async {
    Response signupResponse =
        await HttpService().postRequest(ApiEndpoints.signupEndpoint, signupMap);

    if (signupResponse.statusCode == 200) {
    } else {
      throw CustomException(signupResponse.statusMessage ?? '');
    }
  }
}
