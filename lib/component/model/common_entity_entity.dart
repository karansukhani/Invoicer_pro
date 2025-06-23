import 'dart:convert';

import 'package:invoicer_pro_flutter/generated/json/base/json_field.dart';
import 'package:invoicer_pro_flutter/generated/json/common_entity_entity.g.dart';

export 'package:invoicer_pro_flutter/generated/json/common_entity_entity.g.dart';

@JsonSerializable()
class CommonEntity {
  @JSONField(name: "status_code")
  String? statusCode = '';
  @JSONField(name: "status_message")
  String? statusMessage = '';
  CommonEntityData? data;

  CommonEntity();

  factory CommonEntity.fromJson(Map<String, dynamic> json) =>
      $CommonEntityFromJson(json);

  Map<String, dynamic> toJson() => $CommonEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CommonEntityData {
  CommonEntityData();

  factory CommonEntityData.fromJson(Map<String, dynamic> json) =>
      $CommonEntityDataFromJson(json);

  Map<String, dynamic> toJson() => $CommonEntityDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
