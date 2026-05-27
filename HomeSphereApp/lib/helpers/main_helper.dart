import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../config/api_config.dart';
import '/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

const String keyVersion = "keyVersion";

String getFileType(String fileName) {
  final extension = p.extension(fileName).replaceAll(".", "");

  return "image/$extension";
}

Future<void> setToken(dynamic item) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (item != null) {
    await prefs.setString(MyToken.token, item);
  } else {
    await prefs.remove(MyToken.token);
  }
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? result = prefs.getString(MyToken.token);

  return result;
}

Future<void> setUserInfo(dynamic item) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (item != null) {
    await prefs.setString(MyToken.userInfo, jsonEncode(item));
  } else {
    if (kDebugMode) {
      print("deleted");
    }
    await prefs.remove(MyToken.userInfo);
  }
}

Future<String?> getUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? result = prefs.getString(MyToken.userInfo);

  return result;
}

Future<String> getVersionStr() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // String appName = packageInfo.appName;
  // String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  // String buildNumber = packageInfo.buildNumber;
  return version;
}

// String isValidPhoneNumber(String string) {
//   // Null or empty string is invalid phone number
//   if (string == null || string.isEmpty) {
//     return null;
//   }

//   // You may need to change this pattern to fit your requirement.
//   // I just copied the pattern from here: https://regexr.com/3c53v
//   const pattern = r'^*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
//   final regExp = RegExp(pattern);

//   if (!regExp.hasMatch(string)) {
//     return false;
//   }
//   return true;
// }

Future<void> setVersionStr(String item) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(keyVersion, item);
}

String? requestGetImageApi(String? param) {
  String? theURL = "${MyServer.streamServiceUrl}/img/$param";
  return (theURL);
}

String? getPublicVideoApi(String? param) {
  String? theURL = "${MyServer.publicVideo}/$param";
  if (kDebugMode) {
    print("theUrl ======= $theURL");
  }
  return (theURL);
}

String? getSecureVideoApi(String? param, String? accessToken) {
  String? theURL = "${MyServer.videoUrl}/$param?t=$accessToken";
  if (kDebugMode) {
    print("theURL==$theURL");
  }
  return (theURL);
}

String replaceAtIndex(String val, String replaceChar, int index) {
  var startChars = val.substring(0, index);
  var endChars = val.substring(index + 1, val.length);

  if (replaceChar.isNotEmpty) {
    var result = startChars + replaceChar + endChars;

    if (kDebugMode) {
      print("--$result--");
    }

    return result;
  } else {
    // var startChars = val.substring(0, index);
    // var endChars = val.substring(index + 1, val.length);

    var result = "$startChars $endChars";

    if (kDebugMode) {
      print("===$result==");
    }

    // print("--$startChars--");
    // print("--$endChars--");
    // print("--$replaceChar--");

    return result;
  }
}

bool formValueIsValid(MyInputType inputType, val) {
  RegExp? regex;

  if (inputType == MyInputType.phone) {
    // regex = RegExp(REGEX_PHONE);
  } else if (inputType == MyInputType.email) {
    regex = MyRegEx.myRegexPass;
  } else if (inputType == MyInputType.password ||
      inputType == MyInputType.passwordAgain) {
    regex = MyRegEx.myRegexPass;
  }

  if (!val.isEmpty && regex!.hasMatch(val)) {
    return true;
  }

  return false;
}
