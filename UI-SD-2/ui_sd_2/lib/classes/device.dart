class Device {
  String id;
  String status;
  String type;
  String? value;

  Device({required this.id, required this.status, required this.type, value});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
        id: json['IDDevice'],
        status: json['Status'],
        type: json['Type'],
        value: json['Value']);
  }
}
