import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:ui_sd_2/classes/floor.dart';
import 'package:ui_sd_2/classes/jsons/json_connack.dart';
import '../classes/room_data.dart';
import '../components/room_info.dart';
import '../components/room_movable.dart';
import '../helpers/socket_io_service.dart';
import '../helpers/updating_helpers.dart';

class Building extends StatefulWidget {
  final JsonConnack jsonConnack;

  const Building({super.key, required this.jsonConnack});

  @override
  State<Building> createState() => _BuildingState();
}

class _BuildingState extends State<Building> {
  int i = 0;
  List<Floor> floors = [];
  late TextEditingController _controllerRoomID;
  late TextEditingController _controllerFloorID;
  final CarouselController controller = CarouselController();

  @override
  void initState() {
    setState(() {
      _controllerRoomID = TextEditingController();
      _controllerFloorID = TextEditingController();
      floors = initFloors(widget.jsonConnack);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    socket.on('UPDATEROOM', (data) async {
      for (var floor in floors) {
        var floorID = data['floorID'];
        if (floor.id == floorID) {
          floor.movableItems.add(RoomMovable(
              xPosition: 0,
              yPosition: 0,
              roomInfo: const RoomInfo(),
              roomData: RoomData(devices: [])));
        }
      }
    });

    socket.on('UPDATEFLOOR', ((data) async {
      String floorID = data['floorID'];
      bool contains = false;
      for (int i = 0; i < floors.length; i++) {
        if (floors[i].id == floorID) {
          contains = true;
        }
      }
      if (!contains) {
        // Si ya existe un floor con ese id, no lo mete
        floors.add(Floor(id: floorID, img: 'a', movableItems: []));
      }
    }));
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton:
          ExpandableFab(child: const Icon(Icons.add), children: [
        FloatingActionButton.small(
          heroTag: "new room",
          child: const Icon(Icons.door_front_door_outlined),
          onPressed: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return Dialog(
                      child: Center(
                          child: Column(
                        children: [
                          TextField(
                            controller: _controllerRoomID,
                          ),
                          TextField(
                            controller: _controllerFloorID,
                          ),
                          TextButton(
                              onPressed: (() {
                                newRoomSocket(_controllerRoomID.text,
                                    _controllerFloorID.text, 0.0, 0.0);
                                socket.on('REG-ROOMACK', (data) async {
                                  if (data['returnCode'] == 0) {
                                  } else {}
                                });
                              }),
                              child: const Text('Siguiente'))
                        ],
                      )),
                    );
                  }));

              //Aqui tiene que haber una conexion con sockets para que añadamos un
              /*floors[i].movableItems.add(RoomMovable(
                  xPosition: 0,
                  yPosition: 0,
                  roomInfo: const RoomInfo(),
                  roomData: RoomData(devices: [])));*/
            });
          },
        ),
        FloatingActionButton.small(
          heroTag: "new floor",
          child: const Icon(Icons.layers_outlined),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Center(
                        child: Column(
                      children: [
                        TextField(
                          controller: _controllerFloorID,
                        ),
                        TextButton(
                            onPressed: (() {
                              newFloorSocket(_controllerFloorID.text);
                              socket.on('REG-FLOORACK', (data) async {
                                if (data['returnCode'] == 0) {
                                } else {}
                              });
                            }),
                            child: const Text('Siguiente'))
                      ],
                    )),
                  );
                });
            /*
            setState(() {
              floors.add(Floor(
                id: 'Piso x',
                img:
                    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
                movableItems: [],
              ));
            });*/
          },
        )
      ]),
      body: Stack(
        children: [
          Builder(builder: (context) {
            final double height = MediaQuery.of(context).size.height;
            return CarouselSlider(
              carouselController: controller,
              options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    i = index;
                  });
                },
              ),
              items: floors
                  .map((floor) => Stack(
                        children: [
                          Center(
                              child: Image.network(
                            floor.img,
                            fit: BoxFit.cover,
                            height: height,
                          )),
                          Stack(
                            children:
                                floors[floors.indexOf(floor)].movableItems,
                          )
                        ],
                      ))
                  .toList(),
            );
          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: floors.asMap().entries.map((entry) {
                  return GestureDetector(
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Colors.green)
                                  .withOpacity(i == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
