import '../device.dart';

class JsonDevice {
  List<Device> devices;

  JsonDevice({required this.devices});

  factory JsonDevice.fromJson(Map<String, dynamic> json) {
    return JsonDevice(
        devices: json['Devices']
            .map((element) => Device.fromJson(element))
            .toList()
            .cast<Device>());
  }
}
