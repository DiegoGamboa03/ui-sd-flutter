import 'package:flutter/material.dart';

class Room extends StatefulWidget {
  const Room({super.key});

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  double xPosition = 0;
  double yPosition = 0;

  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: yPosition,
        left: xPosition,
        child: GestureDetector(
            onPanUpdate: (tapInfo) {
              setState(() {
                xPosition += tapInfo.delta.dx;
                yPosition += tapInfo.delta.dy;
              });
            },
            child: Material(
                color: color,
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
