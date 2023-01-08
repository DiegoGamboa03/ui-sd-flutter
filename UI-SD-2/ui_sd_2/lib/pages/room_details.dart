import 'package:flutter/widgets.dart';
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
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return RoomListItem(device: widget.roomData.devices[index]);
        });
  }
}
