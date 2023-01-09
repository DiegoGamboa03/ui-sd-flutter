import 'package:flutter/material.dart';
import 'package:ui_sd_2/classes/room_data.dart';

class Floor {
  String img;
  List<RoomData> roomsData;
  List<Widget> movableItems;

  Floor(
      {required this.img, required this.movableItems, required this.roomsData});
}
