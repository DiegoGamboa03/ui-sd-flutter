import 'package:ui_sd_2/classes/device.dart';

class RoomData {
  String floorID;
  String roomID;
  List<Device> devices;

  RoomData(
      {required this.devices, required this.floorID, required this.roomID});
}
