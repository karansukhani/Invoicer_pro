import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'custom_snack_bar.dart';

Future<bool> isConnected(BuildContext context) async {
  var result = await Connectivity().checkConnectivity();
  var dataStatus = await InternetConnection()
      .hasInternetAccess; // To check actual internet-data is avail or not.
  var status = (ConnectivityResult.mobile == result.first ||
      ConnectivityResult.wifi == result.first);
  if (!status) {
    showSnackBarRed(context,
        "We can't detect an internet connection. please check and try again.");
  } else if (!dataStatus) {
    showSnackBarRed(context,
        "We can't detect an internet connection. please check and try again.");
    return false;
  }
  return status;
}
