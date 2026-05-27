import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main_helper.dart';

Future<dynamic> getErrorNotif(String message) async {
  return Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<dynamic> getInfoNotif(String message) async {
  return Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

dynamic getImage(dynamic img, dynamic defaultImage) {
  if (kDebugMode) {
    print(img);
  }
  if (img == null || img.length == 0) {
    return AssetImage(defaultImage);
  } else {
    //  debugPrint("img==$img  && ${requestGetImageApi(img)}");
    return NetworkImage(requestGetImageApi(img)!);
  }
}
