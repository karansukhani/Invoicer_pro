import 'package:invoicer_pro_flutter/generated/json/base/json_convert_content.dart';
import 'package:invoicer_pro_flutter/notification_service/push_notification_entity.dart';

PushNotificationEntity $PushNotificationEntityFromJson(
    Map<String, dynamic> json) {
  final PushNotificationEntity pushNotificationEntity = PushNotificationEntity();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    pushNotificationEntity.title = title;
  }
  final String? body = jsonConvert.convert<String>(json['body']);
  if (body != null) {
    pushNotificationEntity.body = body;
  }
  final String? type = jsonConvert.convert<String>(json['type']);
  if (type != null) {
    pushNotificationEntity.type = type;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    pushNotificationEntity.image = image;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    pushNotificationEntity.id = id;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    pushNotificationEntity.link = link;
  }
  return pushNotificationEntity;
}

Map<String, dynamic> $PushNotificationEntityToJson(
    PushNotificationEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['body'] = entity.body;
  data['type'] = entity.type;
  data['image'] = entity.image;
  data['id'] = entity.id;
  data['link'] = entity.link;
  return data;
}

extension PushNotificationEntityExtension on PushNotificationEntity {
  PushNotificationEntity copyWith({
    String? title,
    String? body,
    String? type,
    String? image,
    String? id,
    String? link,
  }) {
    return PushNotificationEntity()
      ..title = title ?? this.title
      ..body = body ?? this.body
      ..type = type ?? this.type
      ..image = image ?? this.image
      ..id = id ?? this.id
      ..link = link ?? this.link;
  }
}