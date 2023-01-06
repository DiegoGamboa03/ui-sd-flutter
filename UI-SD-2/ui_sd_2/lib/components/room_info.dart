import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_sd_2/components/icon_text.dart';

class RoomInfo extends StatefulWidget {
  const RoomInfo({super.key});

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
              margin: const EdgeInsets.all(15.0),
              child: const Text('Habitacion 1')),
          Container(
            margin: const EdgeInsets.all(5.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  IconText(text: '1', icon: Icons.abc_outlined),
                  IconText(text: '2', icon: Icons.abc_sharp)
                ]),
          ),
          Container(
            margin: const EdgeInsets.all(5.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  IconText(text: '1', icon: Icons.abc_outlined),
                  IconText(text: '2', icon: Icons.abc_sharp)
                ]),
          )
        ],
      ),
    );
  }
}
