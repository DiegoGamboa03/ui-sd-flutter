import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../classes/device.dart';
import '../classes/room_data.dart';

class RoomListItem extends StatelessWidget {
  const RoomListItem({super.key, required this.device});

  final Device device;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      //Contenedor externo para margenes con otros elementos
      margin: EdgeInsets.only(
          top: height * 0.01, right: width * 0.025, left: width * 0.025),
      child: Material(
        //Color
        color: Colors.lightGreen,
        child: InkWell(
          onTap: () {},
          child: Container(
              color: Colors.transparent,
              height: height * 0.1,
              width: width * 0.95,
              child: Row(
                children: const [FaIcon(FontAwesomeIcons.doorOpen)],
              )),
        ),
      ),
    );
  }
}
