import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket socket = IO.io('http://192.168.1.102:4000', <String, dynamic>{
  'transports': ['websocket'],
  'autoConnect': false,
});

void connectSocket() {
  socket.onConnect((data) {
    print('connect');
  });

  socket.connect();
  connectBroker();
}

void connectBroker() {
  var jsonCONNECT = {"user": "xd", "password": "5678"};
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
