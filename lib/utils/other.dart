import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

bool isDigitsOnly(String? s) {
  if (s == null) {
    return false;
  }
  s = s.replaceAll(' ', '');
  return int.tryParse(s) != null;
}

bool equalsIgnoreCase(String? string1, String? string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();
}

String buildFullAddress(
    String addressLine1,
    String addressLine2,
    ) {
  List<String> addressParts = [];

  if (!addressLine1.isNullOrEmpty()) {
    addressParts.add(addressLine1.replaceAll(',', ''));
  }

  if (!addressLine2.isNullOrEmpty()) {
    addressParts.add(addressLine2.replaceAll(',', ''));
  }

  return addressParts.join(', ');
}

String formatManufacturerName(String manufacturerName, {int maxLength = 5}) {
  if (!manufacturerName.isNullOrEmpty() && (manufacturerName.length ?? 0) > maxLength) {
    return (manufacturerName).substring(0, maxLength).toUpperCase();
  } else {
    return manufacturerName.dashIfNullOrEmpty().toUpperCase();
  }
}

String buildCustomerAddress({
  required String addressLine1,
  required String addressLine2,
  required String city,
}) {
  List<String> addressParts = [];

  if (addressLine1.isNotEmpty) {
    addressParts.add(addressLine1.replaceAll(',', ''));
  }

  if (addressLine2.isNotEmpty) {
    addressParts.add(addressLine2.replaceAll(',', ''));
  }

  if (city.isNotEmpty) {
    addressParts.add(city.replaceAll(',', ''));
  }

  return addressParts.join(', ');
}

int stripWiseShowQtyFromSettings(String? sellingUnit, int? qty, int? size) {
  if (sellingUnit == "strip") {
    // qty always coming as loose from api
    if (qty == 0) {
      return qty ?? 0;
    } else {
      try {
        return qty! ~/ size!;
      } catch (e) {
        return 0;
      } // cast to int
    }
  } else {
    return qty ?? 0;
  }
}

Future<int> stripWiseShowQty(int? qty, int? size) async {
  var isStripWise = true;
  if (isStripWise) {
    // qty always coming as loose from api
    if (qty == 0) {
      return qty ?? 0;
    } else {
      try {
        return qty! ~/ size!;
      } catch (e) {
        return 0;
      } // cast to int
    }
  }
}

int LooseWiseShowQtyFromSettings(String? sellingUnit, int? qty, int? size) {
  if (sellingUnit == "strip") {
    return (qty ?? 0) * (size ?? 1);
  } else {
    return qty ?? 0;
  }
}

int allTimeStripWiseQty(int? qty, int? size) {
  if (qty == 0) {
    return qty ?? 0;
  } else {
    return qty! ~/ size!;
  }
}

Future<void> makingPhoneCall({required String mobileNumber}) async {
  launchUrl(
    Uri.parse(mobileNumber),
    mode: LaunchMode.platformDefault,
  );
}

// to open external url
Future<void> exploreUrl(Uri _url) async {
  if (await canLaunchUrl(_url)) {
    await launchUrl(_url, mode: LaunchMode.externalApplication);
  } else {
    debugPrint("Oops! We can't open this page.");
    return;
  }
}

// signup screen
bool containWords(String inputString, List<String> wordList) {
  bool found = false;

  for (String word in wordList) {
    if (inputString.toLowerCase().contains(word.toLowerCase())) {
      found = true;
      break;
    }
  }
  return found;
}

// capitalize first letter
extension StringExtension on String? {
  String capitalize() {
    if (this == null || this!.isEmpty) {
      return "";
    }
    return "${this?[0].toUpperCase()}${this?.substring(1)}";
  }

  //This removes _ and capitalizes the first letter
  String removeUnderscoresAndCapitalize() {
    if (this == null || this == "") {
      return "-";
    }

    // Split the input string by underscores
    List<String>? words = this?.split('_');

    // Capitalize the first letter of each word
    for (int index = 0; index < (words ?? []).length; index++) {
      if ((words ?? [])[index].isNotEmpty) {
        (words ?? [])[index] = (words ?? [])[index][0].toUpperCase() + (words ?? [])[index].substring(1).toLowerCase();
      }
    }

    // Join the words back into a single string
    return (words ?? []).join(' ');
  }

  String removeSpaceWithUnderScore() {
    if (this == null || (this ?? '').isEmpty) {
      return "";
    }

    return this!.replaceAll(" ", "_");
  }

  String removeUnderscoresWithSpace() {
    return (this ?? '').replaceAll('_', ' ');
  }

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  String dashIfNullOrEmpty() {
    if (this == null || this!.isEmpty) {
      return "-";
    }
    return "$this";
  }
}

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}

bool isValidPercentage(String text) {
  final number = double.tryParse(text);
  return number != null && number >= 0 && number <= 100;
}

extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

double calculatePercentageAmount(double value, double discountPercentage) {
  if (value == 0.0 || discountPercentage == 0.0) {
    return 0.0;
  }

  var discount_amount = ((value * discountPercentage) / 100);
  return discount_amount;
}

double getFileSizeInMB(int sizeInBytes, {int decimals = 2}) {
  // Convert bytes to megabytes
  double sizeInMB = sizeInBytes / (1024 * 1024);

  // Round to the specified number of decimal places
  return double.parse(sizeInMB.toStringAsFixed(decimals));
}