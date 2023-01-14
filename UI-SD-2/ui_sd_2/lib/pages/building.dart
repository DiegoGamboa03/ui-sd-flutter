import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:ui_sd_2/classes/floor.dart';
import 'package:ui_sd_2/classes/jsons/json_connack.dart';
import 'package:ui_sd_2/classes/room_data.dart';
import 'package:ui_sd_2/components/room.dart';
import 'package:ui_sd_2/components/room_info.dart';

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
  @override
  void initState() {
    setState(() {
      floors = initFloors(widget.jsonConnack);
    });
    super.initState();
  }

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton:
          ExpandableFab(child: const Icon(Icons.add), children: [
        FloatingActionButton.small(
          child: const Icon(Icons.door_front_door_outlined),
          onPressed: () {
            setState(() {
              floors[i].movableItems.add(Room(
                  xPosition: 0,
                  yPosition: 0,
                  roomInfo: const RoomInfo(),
                  roomData: RoomData(devices: [])));
            });
          },
        ),
        FloatingActionButton.small(
          child: const Icon(Icons.layers_outlined),
          onPressed: () {
            setState(() {
              floors.add(Floor(
                img:
                    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
                movableItems: [],
              ));
            });
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
