import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String? message}) => Fluttertoast.showToast(
    msg: message!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.pink,
    textColor: Colors.white,
    fontSize: 16.0);
