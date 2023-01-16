import 'package:flutter/cupertino.dart';

class UpdateDevice {
  String id;
  String status;
  String value;

  UpdateDevice({required this.id, required this.status, required this.value});

  factory UpdateDevice.fromJson(Map<String, dynamic> json) {
    return UpdateDevice(
      id: json['IDDevice'],
      status: json['Status'],
      value: json['Value'],
    );
  }
}
