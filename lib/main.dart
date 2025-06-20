import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoicer_pro_flutter/theme/theme.dart';
import 'package:invoicer_pro_flutter/utils/firebase_options.dart';
import 'router/app_router.dart' as router;
import 'notification_service/push_notification_entity.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandler(message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificationEntity pushNotification =
      PushNotificationEntity.fromJson(message.data);
}

@pragma('vm:entry-point')
Future onDidReceiveBackgroundNotificationResponse(details) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificationEntity pushNotification =
      PushNotificationEntity.fromJson(jsonDecode(details.payload ?? ""));
}

// For handle notification click when app is in FG. In BG and Killed state no need to call.
// Firebase automatically show in those case.
// When app is in FG and user clicked on Notification this method is called.
@pragma('vm:entry-point')
Future onDidReceiveNotificationResponse(details) async {
  // dev.log("Firebase onSelectNotification payload: ${details.payload}");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificationEntity pushNotification =
      PushNotificationEntity.fromJson(jsonDecode(details.payload ?? ""));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String activeRouteName = ""; // to get the route name

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    crashlyticsInit();

    runApp(const MyApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

Future<void> crashlyticsInit() async {
  // The following lines are the same as previously explained in "Handling uncaught errors"
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.st
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Invoicer Pro',
      theme: lightThemeData(context),
      //on generate will automatically takes first route
      onGenerateRoute: router.generateRoute,
    );
  }
}
