import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:ui_sd_2/components/room.dart';
import 'package:ui_sd_2/components/room_info.dart';

List<List<Widget>> listMovableItems = [];

class Building extends StatefulWidget {
  const Building({super.key});

  @override
  State<Building> createState() => _BuildingState();
}

class _BuildingState extends State<Building> {
  int i = 0;
  final List<String> imgList = [
    //Lista de imagenes sacadas de internet, no tienen nada que ver, simplemente de prueba
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  void initState() {
    List<Widget> movableItems0 = []; //Almacena todas las habitaciones
    List<Widget> movableItems1 = []; //Almacena todas las habitaciones
    List<Widget> movableItems2 = []; //Almacena todas las habitaciones
    List<Widget> movableItems3 = []; //Almacena todas las habitaciones
    List<Widget> movableItems4 = []; //Almacena todas las habitaciones
    List<Widget> movableItems5 = []; //Almacena todas las habitaciones
    listMovableItems = [
      movableItems0,
      movableItems1,
      movableItems2,
      movableItems3,
      movableItems4,
      movableItems5
    ]; //Al
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CarouselController controller = CarouselController();

    return Scaffold(
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton:
            ExpandableFab(child: const Icon(Icons.add), children: [
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.door_front_door_outlined),
            onPressed: () {
              setState(() {
                listMovableItems[i].add(Room(
                    xPosition: 0, yPosition: 0, roomInfo: const RoomInfo()));
              });
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.layers_outlined),
            onPressed: () {},
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
                items: imgList
                    .map((item) => Stack(
                          children: [
                            Center(
                                child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              height: height,
                            )),
                            Stack(
                              children: listMovableItems[imgList.indexOf(item)],
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
                  children: imgList.asMap().entries.map((entry) {
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
        ));
  }
}
