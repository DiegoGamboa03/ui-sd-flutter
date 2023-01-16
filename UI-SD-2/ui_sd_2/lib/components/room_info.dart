import 'package:flutter/material.dart';

class RoomInfo extends StatefulWidget {
  final String roomID;
  const RoomInfo({super.key, required this.roomID});

  @override
  State<RoomInfo> createState() => _RoomInfoState();
}

class _RoomInfoState extends State<RoomInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(15.0), child: Text(widget.roomID)),
        ],
      ),
    );
  }
}
