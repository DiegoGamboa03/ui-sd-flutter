import 'dart:ffi';

import 'package:ui_sd_2/classes/device.dart';

class JsonRoom {
  String roomName;
  double posX;
  double posY;
  List<Device> devices;

  JsonRoom(
      {required this.roomName,
      required this.devices,
      required this.posX,
      required this.posY});

  factory JsonRoom.fromJson(Map<String, dynamic> json) {
    return JsonRoom(
        roomName: json['IDRoom'],
        posX: json['PosX'].toDouble(),
        posY: json['PosY'].toDouble(),
        devices: json['Devices']
            .map((element) => Device.fromJson(element))
            .toList()
            .cast<Device>());
  }
}
