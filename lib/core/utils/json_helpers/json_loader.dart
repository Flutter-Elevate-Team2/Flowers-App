import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadJson(String jsonFile) async {
  try {
    final String jsonString = await rootBundle.loadString(jsonFile);
    final data = json.decode(jsonString);

    return data;
  } catch (e) {
    debugPrint("exception file:${e.toString()}");
    return {};
  }
}