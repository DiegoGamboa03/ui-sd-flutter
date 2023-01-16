import 'package:flutter/material.dart';
import 'package:ui_sd_2/classes/device.dart';
import 'package:ui_sd_2/components/room_list_item.dart';
import '../classes/room_data.dart';
import '../helpers/socket_io_service.dart';

class RoomDetails extends StatefulWidget {
  const RoomDetails({super.key, required this.roomData});

  final RoomData roomData;

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  late TextEditingController _controllerDeviceID;
  late TextEditingController _controllerDeviceType;
  List<String> devicesType = ['bulb', 'ac', 'door', 'sensor'];
  late String selectedItem;
  @override
  void initState() {
    _controllerDeviceType = TextEditingController();
    _controllerDeviceID = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Center(
                      child: Column(
                    children: [
                      TextField(
                        controller: _controllerDeviceID,
                      ),
                      TextField(
                        controller: _controllerDeviceType,
                      ),
                      TextButton(
                          onPressed: (() {
                            String topic =
                                '${widget.roomData.floorID}-${widget.roomData.roomID}-${_controllerDeviceID.text}switch';

                            newDeviceSocket(
                                _controllerDeviceID.text,
                                _controllerDeviceType.text,
                                'off',
                                null,
                                widget.roomData.roomID,
                                topic);
                            setState(() {
                              widget.roomData.devices.add(Device(
                                  id: _controllerDeviceID.text,
                                  status: 'off',
                                  type: _controllerDeviceType.text,
                                  switchTopic: topic));
                            });
                          }),
                          child: const Text('Siguiente'))
                    ],
                  )),
                );
              });
        },
      ),
      body: ListView.builder(
          itemCount: widget.roomData.devices.length,
          itemBuilder: (BuildContext context, int index) {
            return RoomListItem(
              device: widget.roomData.devices[index],
              roomID: widget.roomData.roomID,
              floorID: widget.roomData.floorID,
            );
          }),
    );
  }
}
