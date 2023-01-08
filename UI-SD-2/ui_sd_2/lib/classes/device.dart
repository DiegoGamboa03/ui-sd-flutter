class Device {
  String id;
  String status;
  String type;

  Device({required this.id, required this.status, required this.type});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(id: json['IDDevice'], status: json['Status'], type: 'bulb');
  }
}
