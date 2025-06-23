import 'package:invoicer_pro_flutter/component/model/common_entity_entity.dart';
import 'package:invoicer_pro_flutter/generated/json/base/json_convert_content.dart';

CommonEntity $CommonEntityFromJson(Map<String, dynamic> json) {
  final CommonEntity commonEntity = CommonEntity();
  final String? statusCode = jsonConvert.convert<String>(json['status_code']);
  if (statusCode != null) {
    commonEntity.statusCode = statusCode;
  }
  final String? statusMessage =
      jsonConvert.convert<String>(json['status_message']);
  if (statusMessage != null) {
    commonEntity.statusMessage = statusMessage;
  }
  final CommonEntityData? data =
      jsonConvert.convert<CommonEntityData>(json['data']);
  if (data != null) {
    commonEntity.data = data;
  }
  return commonEntity;
}

Map<String, dynamic> $CommonEntityToJson(CommonEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status_code'] = entity.statusCode;
  data['status_message'] = entity.statusMessage;
  data['data'] = entity.data?.toJson();
  return data;
}

extension CommonEntityExtension on CommonEntity {
  CommonEntity copyWith({
    String? statusCode,
    String? statusMessage,
    CommonEntityData? data,
  }) {
    return CommonEntity()
      ..statusCode = statusCode ?? this.statusCode
      ..statusMessage = statusMessage ?? this.statusMessage
      ..data = data ?? this.data;
  }
}

CommonEntityData $CommonEntityDataFromJson(Map<String, dynamic> json) {
  final CommonEntityData commonEntityData = CommonEntityData();
  return commonEntityData;
}

Map<String, dynamic> $CommonEntityDataToJson(CommonEntityData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

extension CommonEntityDataExtension on CommonEntityData {}
