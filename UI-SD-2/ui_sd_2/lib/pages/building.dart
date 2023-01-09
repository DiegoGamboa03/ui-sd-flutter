import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:ui_sd_2/classes/floor.dart';
import 'package:ui_sd_2/classes/room_data.dart';
import 'package:ui_sd_2/components/room.dart';
import 'package:ui_sd_2/components/room_info.dart';

class Building extends StatefulWidget {
  const Building({super.key});

  @override
  State<Building> createState() => _BuildingState();
}

class _BuildingState extends State<Building> {
  int i = 0;
  List<Floor> floors = [
    Floor(
        img:
            'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
        movableItems: [],
        roomsData: []),
    Floor(
        img:
            'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
        movableItems: [],
        roomsData: []),
    Floor(
        img:
            'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
        movableItems: [],
        roomsData: []),
  ];
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
                  roomsData: []));
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
