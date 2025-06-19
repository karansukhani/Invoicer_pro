import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/push_notification_entity.g.dart';


@JsonSerializable()
class PushNotificationEntity {
  String? title;
  String? body;
  String? type;
  String? image;
  String? id;
  String? link;

  PushNotificationEntity();

  factory PushNotificationEntity.fromJson(Map<String, dynamic> json) => $PushNotificationEntityFromJson(json);

  Map<String, dynamic> toJson() => $PushNotificationEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}