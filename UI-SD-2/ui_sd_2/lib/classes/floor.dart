import 'package:flutter/material.dart';
import 'package:ui_sd_2/classes/room_data.dart';

class Floor {
  String id;
  String img;
  List<Widget> movableItems;

  Floor({required this.id, required this.img, required this.movableItems});
}
