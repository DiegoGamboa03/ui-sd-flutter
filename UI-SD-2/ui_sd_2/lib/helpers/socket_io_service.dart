import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket socket = IO.io('http://192.168.1.102:4000', <String, dynamic>{
  'transports': ['websocket'],
  'autoConnect': false,
});

void connectSocket(String user, String password) {
  socket.onConnect((data) {
    print('connect');
  });

  socket.connect();
  connectBroker(user, password);
}

void connectBroker(String user, String password) {
  //var jsonCONNECT = {"user": "xd", "password": "5678"};
  var jsonCONNECT = {"user": user, "password": password};
  socket.emit('CONNECT', jsonCONNECT);
}

void newFloorSocket(String floorID) {
  var jsonREGFLOOR = {"floorID": floorID};
  socket.emit('REG-FLOOR', jsonREGFLOOR);
}

void newRoomSocket(String roomID, String floorID, double posX, double posY) {
  var jsonREGROOM = {
    "roomID": roomID,
    "floorID": floorID,
    "posX": posX,
    "posY": posY
  };
  socket.emit('REG-ROOM', jsonREGROOM);
}

void newDeviceSocket(String deviceID, String type, String status, String? value,
    String roomID, String topic) {
  var jsonREGDEVICE = {
    "deviceID": deviceID,
    "type": type,
    "status": status,
    "value": value,
    "room": roomID,
    "switchTopic": topic
  };
  socket.emit('REG-DEVICE', jsonREGDEVICE);
}

void publish(String deviceID, String topic, String message) {
  var jsonPUBLILSH = {"deviceID": deviceID, "topic": topic, "message": message};
  socket.emit('PUBLISH', jsonPUBLILSH);
}

void newRuleSocket(String deviceID, String topic, String ruleID, String fact,
    String operator, String value, String message) {
  var jsonREGRULE = {
    "ruleID": ruleID,
    "fact": fact,
    "operator": operator,
    "value": value,
    "deviceID": deviceID,
    "topic": topic,
    "message": message
  };
  socket.emit('REG-RULE', jsonREGRULE);
}
