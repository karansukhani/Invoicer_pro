import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/asset_constants.dart';
import '../../constants/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(15.0),
        alignment: Alignment.center,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  AssetsConstants.splashImage,
                  fit: BoxFit.cover,
                  height: 300.0,
                  width: 300.0,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 35.0),
              child: RichText(
                text: TextSpan(
                  text: "Invoicer\t\t",
                  style: TextStyles.customFont(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: "Pro",
                      style: TextStyles.customFont(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //This method redirects to the respective screen according to the data got
  Future<void> redirectToScreen() async {
    String nextScreen = "";
    Timer(const Duration(seconds: 1), () async {});
  }
}
