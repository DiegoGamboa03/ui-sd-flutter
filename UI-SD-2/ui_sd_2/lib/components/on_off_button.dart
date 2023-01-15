import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonOnOff extends StatelessWidget {
  const ButtonOnOff({super.key});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {},
      elevation: 2.0,
      fillColor: Colors.white,
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: const FaIcon(FontAwesomeIcons.toggleOn),
    );
  }
}
