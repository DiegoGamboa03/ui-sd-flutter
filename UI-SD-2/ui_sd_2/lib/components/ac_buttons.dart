import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonAC extends StatelessWidget {
  const ButtonAC({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_upward,
          ),
          onPressed: () {},
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(15.0),
          shape: const CircleBorder(),
          child: const FaIcon(FontAwesomeIcons.toggleOn),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_downward),
          onPressed: () {},
        ),
      ],
    );
  }
}
