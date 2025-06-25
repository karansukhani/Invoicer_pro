import 'package:flutter/material.dart';
import 'package:invoicer_pro_flutter/router/routing_constants.dart';
import 'package:invoicer_pro_flutter/screen/login/login_screen.dart';
import 'package:invoicer_pro_flutter/screen/signup_screen/signup_screen.dart';
import 'package:invoicer_pro_flutter/screen/splash_screen/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreenRoute:
      return MaterialPageRoute(builder: (_) {
        return const SplashScreen();
      });
    case loginScreenRoute:
      return MaterialPageRoute(builder: (_) {
        return LoginScreen.create();
      });
    case signupScreenRoute:
      return MaterialPageRoute(builder: (_){
        return SignupScreen.create();
      });
    default:
      return MaterialPageRoute(builder: (_) {
        return Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        );
      });
  }
}
