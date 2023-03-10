import 'package:flutter/material.dart';
import 'package:ui_sd_2/classes/jsons/json_connack.dart';
import 'package:ui_sd_2/helpers/socket_io_service.dart';

import 'building.dart';

String user = '';
String password = '';

///Login de la App
class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'Welcome to the log in',
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'email',
                  ),
                  onChanged: (value) {
                    user = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'password',
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  onPressed: () {
                    connectSocket(user, password);
                    socket.on('CONNACK', (data) async {
                      JsonConnack jsonConnack = JsonConnack.fromJson(data);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Building(jsonConnack: jsonConnack)),
                      );
                    });
                  },
                  child: const Text('Boton'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
