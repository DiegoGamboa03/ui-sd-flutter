import 'package:flutter/material.dart';
import 'package:ui_sd_2/components/room_list_item.dart';
import '../classes/room_data.dart';

class RoomDetails extends StatefulWidget {
  const RoomDetails({super.key, required this.roomData});

  final RoomData roomData;

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          //Aqui va logica para añadir todos los dispositvos
        },
      ),
      body: ListView.builder(
          itemCount: widget.roomData.devices.length,
          itemBuilder: (BuildContext context, int index) {
            return RoomListItem(device: widget.roomData.devices[index]);
          }),
    );
  }
}
