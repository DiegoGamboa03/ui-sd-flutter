import 'package:flutter/material.dart';

class Device {
  String id;
  String status;
  String type;
  String? value;
  String switchTopic;

  Device(
      {required this.id,
      required this.status,
      required this.type,
      value,
      required this.switchTopic});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
        id: json['IDDevice'],
        status: json['Status'],
        type: json['Type'],
        value: json['Value'],
        switchTopic: json['SwitchTopic']);
  }
}
