import 'package:flutter/material.dart';
import 'package:ui_sd_2/classes/room_data.dart';
import 'package:ui_sd_2/components/room_info.dart';
import 'package:ui_sd_2/helpers/socket_io_service.dart';
import 'package:ui_sd_2/pages/room_details.dart';

import '../classes/device.dart';

// ignore: must_be_immutable
class RoomMovable extends StatefulWidget {
  RoomMovable(
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
  State<RoomMovable> createState() => _RoomState();
}

class _RoomState extends State<RoomMovable> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;

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
                  onTap: () {
                    var jsonCHECKROOM = {'roomID': widget.roomData.roomID};
                    socket.emit('CHECK-ROOM-DEVICES', jsonCHECKROOM);
                    socket.on('CHECK-ROOM-DEVICESACK', ((data) async {
                      var list = data['checkDevices']
                          .map((element) {
                            return Device.fromJson(element);
                          })
                          .toList()
                          .cast<Device>();
                      if (list.length > 0) {
                        widget.roomData.devices = list;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RoomDetails(roomData: widget.roomData)),
                      );
                    }));
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: screenheight * 0.18,
                    width: screenheight * 0.18,
                    child: widget.roomInfo,
                  ),
                ))));
  }
}
