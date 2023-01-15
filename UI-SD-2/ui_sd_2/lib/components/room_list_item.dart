import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui_sd_2/components/on_off_button.dart';
import '../classes/device.dart';
import 'ac_buttons.dart';

class RoomListItem extends StatefulWidget {
  const RoomListItem({super.key, required this.device});

  final Device device;

  @override
  State<RoomListItem> createState() => _RoomListItemState();
}

class _RoomListItemState extends State<RoomListItem> {
  FaIcon icon = FaIcon(FontAwesomeIcons.doorOpen);
  @override
  void initState() {
    if (widget.device.type == 'bulb') {
      if (widget.device.status == 'on') {
        icon = const FaIcon(FontAwesomeIcons.lightbulb);
      } else {
        icon = const FaIcon(FontAwesomeIcons.solidLightbulb);
      }
    } else if (widget.device.type == 'sensor') {
      icon = const FaIcon(FontAwesomeIcons.circle);
    } else if (widget.device.type == 'door') {
      if (widget.device.status == 'open') {
        icon = const FaIcon(FontAwesomeIcons.doorOpen);
      } else {
        icon = const FaIcon(FontAwesomeIcons.doorClosed);
      }
    } else if (widget.device.type == 'ac') {
      if (widget.device.status == 'on') {
        icon = const FaIcon(FontAwesomeIcons.fan);
      } else {
        icon = const FaIcon(FontAwesomeIcons.x);
      }
    }
    super.initState();
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: icon,
                  ),
                  widget.device.type == 'ac'
                      ? const ButtonAC()
                      : const ButtonOnOff(),
                ],
              )),
        ),
      ),
    );
  }
}
