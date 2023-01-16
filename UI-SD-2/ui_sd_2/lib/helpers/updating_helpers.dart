import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ui_sd_2/classes/device.dart';
import 'package:ui_sd_2/classes/jsons/json_connack.dart';
import 'package:ui_sd_2/classes/room_data.dart';
import 'package:ui_sd_2/components/room_info.dart';
import '../classes/floor.dart';
import '../components/room_movable.dart';

List<Floor> initFloors(JsonConnack jsonConnack) {
  List<Floor> floors = [];
  for (int i = 0; i < jsonConnack.jsonFloors.length; i++) {
    //Recorre cada piso
    //Floor floor = Floor();
    List<Widget> movableItems = [];
    for (int j = 0; j < jsonConnack.jsonFloors[i].rooms.length; j++) {
      //Recorre cada habitacion
      List<Device> devices = [];
      for (int k = 0;
          k < jsonConnack.jsonFloors[i].rooms[j].devices.length;
          k++) {
        //Recorre cada dispositivo de cada habitacion
        devices.add(jsonConnack.jsonFloors[i].rooms[j].devices[k]);
      }
      movableItems.add(RoomMovable(
        roomData: RoomData(
            floorID: jsonConnack.jsonFloors[i].floorID,
            roomID: jsonConnack.jsonFloors[i].rooms[j].roomName,
            devices: devices),
        roomInfo: RoomInfo(roomID: jsonConnack.jsonFloors[i].rooms[j].roomName),
        xPosition: 0,
        yPosition: 0,
      ));
    }
    floors.add(Floor(
        id: jsonConnack.jsonFloors[i].floorID,
        img:
            'https://drive.google.com/file/d/1l7YDSPQjnCje5bYv83OxSGk7RsdzwM8K/view?usp=share_link',
        movableItems: movableItems));
  }
  return floors;
}
