import 'package:dio/dio.dart';
import 'package:invoicer_pro_flutter/utils/custom_exception.dart';

import '../../../Api/http_service.dart';
import '../../../Api/support_api_params.dart';
import '../../component/model/common_entity_entity.dart';

class LogoutRepository {
  Future<CommonEntity> logoutApi() async {
    Response logoutResponse = await HttpService()
        .postRequest("login/logout", await defaultApiParams());
    if (logoutResponse.statusCode == 200) {
      CommonEntity commonEntity = $CommonEntityFromJson(logoutResponse.data);
      return commonEntity;
    } else {
      throw CustomException("Something went wrong");
    }
  }
}
