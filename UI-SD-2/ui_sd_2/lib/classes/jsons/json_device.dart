import 'package:ui_sd_2/classes/device.dart';

class JsonDevice {
  String roomName;
  List<Device> devices;

  JsonDevice({required this.roomName, required this.devices});

  factory JsonDevice.fromJson(Map<String, dynamic> json) {
    return JsonDevice(
        roomName: json['IDRoom'],
        devices: json['Devices']
            .map((element) => Device.fromJson(element))
            .toList()
            .cast<Device>());
  }
}
