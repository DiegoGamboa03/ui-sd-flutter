import 'package:flutter/material.dart';

class Room extends StatefulWidget {
  Room({
    super.key,
    required this.xPosition,
    required this.yPosition,
  });

  late double xPosition;
  late double yPosition;

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
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
                    height: 150,
                    width: 150,
                  ),
                ))));
  }
}
