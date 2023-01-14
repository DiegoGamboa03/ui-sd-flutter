import 'json_rooms.dart';

class JsonFloor {
  String floorID;
  List<JsonRoom> rooms;

  JsonFloor({required this.rooms, required this.floorID});

  factory JsonFloor.fromJson(Map<String, dynamic> json) {
    return JsonFloor(
        floorID: json['IDFloor'],
        rooms: json['Rooms']
            .map((element) => JsonRoom.fromJson(element))
            .toList()
            .cast<JsonRoom>());
  }
}
