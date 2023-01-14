import 'package:ui_sd_2/classes/device.dart';

class JsonRoom {
  String roomName;
  List<Device> devices;

  JsonRoom({required this.roomName, required this.devices});

  factory JsonRoom.fromJson(Map<String, dynamic> json) {
    return JsonRoom(
        roomName: json['IDRoom'],
        devices: json['Devices']
            .map((element) => Device.fromJson(element))
            .toList()
            .cast<Device>());
  }
}
