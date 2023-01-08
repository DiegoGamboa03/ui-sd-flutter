import 'dart:convert';

import 'package:ui_sd_2/classes/jsons/json_device.dart';

class JsonConnack {
  int returnCode;
  List<JsonDevice> jsonDevice = [];

  JsonConnack({required this.returnCode, required this.jsonDevice});

  factory JsonConnack.fromJson(Map<String, dynamic> json) {
    return JsonConnack(
        returnCode: json['returnCode'],
        jsonDevice: json['jsonDevices']
            .map((element) => JsonDevice.fromJson(element))
            .toList()
            .cast<JsonDevice>());
  }
}
