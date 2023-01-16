import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../classes/device.dart';
import '../helpers/socket_io_service.dart';

class RoomListItem extends StatefulWidget {
  const RoomListItem(
      {super.key,
      required this.device,
      required this.floorID,
      required this.roomID});
  final String floorID;
  final String roomID;
  final Device device;

  @override
  State<RoomListItem> createState() => _RoomListItemState();
}

class _RoomListItemState extends State<RoomListItem> {
  FaIcon icon = const FaIcon(FontAwesomeIcons.doorOpen);
  late String message;
  late TextEditingController _controllerTopic;
  late TextEditingController _controllerRuleID;
  late TextEditingController _controllerFact;
  late TextEditingController _controllerOperator;
  late TextEditingController _controllerValue;
  late TextEditingController _controllerMessage;
  @override
  void initState() {
    if (widget.device.type == 'bulb') {
      if (widget.device.status == 'state:on') {
        icon = const FaIcon(FontAwesomeIcons.lightbulb);
      } else {
        icon = const FaIcon(FontAwesomeIcons.solidLightbulb);
      }
    } else if (widget.device.type == 'sensor') {
      icon = const FaIcon(FontAwesomeIcons.circle);
    } else if (widget.device.type == 'door') {
      if (widget.device.status == 'state:on') {
        icon = const FaIcon(FontAwesomeIcons.doorOpen);
      } else {
        icon = const FaIcon(FontAwesomeIcons.doorClosed);
      }
    } else if (widget.device.type == 'ac') {
      if (widget.device.status == 'state:on') {
        icon = const FaIcon(FontAwesomeIcons.fan);
      } else {
        icon = const FaIcon(FontAwesomeIcons.x);
      }
    }
    message = widget.device.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    socket.on('PUBLISH', ((data) async {
      var length = data.length;
      for (int i = 0; i < length; i++) {
        String id = data[i]['Device'];
        String message = data[i]['Message'];
        if (widget.device.id == id) {
          widget.device.status = message;
        }
      }
      setState(() {
        if (widget.device.type == 'bulb') {
          if (widget.device.status == 'state:on') {
            icon = const FaIcon(FontAwesomeIcons.lightbulb);
          } else {
            icon = const FaIcon(FontAwesomeIcons.solidLightbulb);
          }
        } else if (widget.device.type == 'sensor') {
          icon = const FaIcon(FontAwesomeIcons.circle);
        } else if (widget.device.type == 'door') {
          if (widget.device.status == 'state:on') {
            icon = const FaIcon(FontAwesomeIcons.doorOpen);
          } else {
            icon = const FaIcon(FontAwesomeIcons.doorClosed);
          }
        } else if (widget.device.type == 'ac') {
          if (widget.device.status == 'state:on') {
            icon = const FaIcon(FontAwesomeIcons.fan);
          } else {
            icon = const FaIcon(FontAwesomeIcons.x);
          }
        }
        message = widget.device.status;
      });
    }));

    return Container(
      //Contenedor externo para margenes con otros elementos
      margin: EdgeInsets.only(
          top: height * 0.01, right: width * 0.025, left: width * 0.025),
      child: Material(
        //Color
        color: Colors.lightGreen,
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Center(
                        child: Column(
                      children: [
                        TextField(
                          controller: _controllerTopic,
                        ),
                        TextField(
                          controller: _controllerRuleID,
                        ),
                        TextField(
                          controller: _controllerFact,
                        ),
                        TextField(
                          controller: _controllerOperator,
                        ),
                        TextField(
                          controller: _controllerValue,
                        ),
                        TextField(
                          controller: _controllerMessage,
                        ),
                        TextButton(
                            onPressed: (() {
                              newRuleSocket(
                                  widget.device.id,
                                  _controllerTopic.text,
                                  _controllerRuleID.text,
                                  _controllerFact.text,
                                  _controllerOperator.text,
                                  _controllerValue.text,
                                  _controllerMessage.text);
                            }),
                            child: const Text('Siguiente'))
                      ],
                    )),
                  );
                });
          },
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
                      ? Column(
                          //Si es ac
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_upward,
                              ),
                              onPressed: () {},
                            ),
                            RawMaterialButton(
                              onPressed: () {},
                              elevation: 2.0,
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(15.0),
                              shape: const CircleBorder(),
                              child: const FaIcon(FontAwesomeIcons.toggleOn),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_downward),
                              onPressed: () {},
                            ),
                          ],
                        )
                      : RawMaterialButton(
                          //Si no es ac
                          onPressed: () {
                            if (message == 'on') {
                              message = 'state:off';
                            } else {
                              message = 'state:on';
                            }
                            publish('APP', widget.device.switchTopic, message);
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          padding: const EdgeInsets.all(15.0),
                          shape: const CircleBorder(),
                          child: const FaIcon(FontAwesomeIcons.toggleOn),
                        ),
                ],
              )),
        ),
      ),
    );
  }
}
