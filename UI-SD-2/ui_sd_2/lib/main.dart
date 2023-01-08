import 'package:flutter/material.dart';
import 'package:ui_sd_2/pages/building.dart';
import 'package:ui_sd_2/pages/login.dart';
import 'package:ui_sd_2/pages/room_details.dart';

import 'classes/device.dart';
import 'classes/room_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Device> devices = [
      Device(id: '1', status: 'on', type: 'Bulb'),
      Device(id: '2', status: 'close', type: 'Door'),
      Device(id: '3', status: 'on', type: 'Bulb')
    ];
    var room_data = RoomData(devices: devices);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Login());
  }
}
