import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

import '../utils/shared_preference/pref_key.dart';
import '../utils/shared_preference/shared_pref.dart';

Future<Map<String, String>> defaultApiParams() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  Map<String, String> defaultApiMap = {
    //For structured staff passing login_parent_id
    'user_id': await SharedPref.getString(PrefKey.userId, defaultValue: "0"),
    'fcmtoken': await SharedPref.getString(PrefKey.fcmToken),
    'app_version': packageInfo.buildNumber,
    'os': Platform.isAndroid ? "android" : "ios",
    'source': "invoicer_pro"
  };
  return defaultApiMap;
}
