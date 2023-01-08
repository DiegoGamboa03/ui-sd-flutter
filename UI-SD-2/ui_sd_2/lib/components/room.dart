import 'package:flutter/material.dart';
import 'package:ui_sd_2/classes/room_data.dart';
import 'package:ui_sd_2/components/room_info.dart';

// ignore: must_be_immutable
class Room extends StatefulWidget {
  Room(
      {super.key,
      required this.xPosition,
      required this.yPosition,
      required this.roomInfo,
      required this.roomData});

  late double xPosition;
  late double yPosition;
  late RoomInfo roomInfo;
  RoomData roomData;
  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return Positioned(
        top: widget.yPosition,
        left: widget.xPosition,
        child: GestureDetector(
            onPanUpdate: (tapInfo) {
              setState(() {
                widget.xPosition += tapInfo.delta.dx;
                widget.yPosition += tapInfo.delta.dy;
              });
            },
            child: Material(
                color: Colors.grey,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    height: screenheight * 0.18,
                    width: screenheight * 0.18,
                    child: widget.roomInfo,
                  ),
                ))));
  }
}
