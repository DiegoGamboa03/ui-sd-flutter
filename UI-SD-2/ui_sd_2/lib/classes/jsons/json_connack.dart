import 'package:ui_sd_2/classes/jsons/json_device.dart';
import 'json_floor.dart';

class JsonConnack {
  int returnCode;
  List<JsonFloor> jsonFloors = [];

  JsonConnack({required this.returnCode, required this.jsonFloors});

  factory JsonConnack.fromJson(Map<String, dynamic> json) {
    return JsonConnack(
        returnCode: json['returnCode'],
        jsonFloors: json['jsonFloors']
            .map((element) => JsonFloor.fromJson(element))
            .toList()
            .cast<JsonFloor>());
  }
}
