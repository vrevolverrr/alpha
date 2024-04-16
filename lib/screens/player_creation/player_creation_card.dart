import 'package:flutter/material.dart';

class PlayerCreationCard extends StatelessWidget {
  const PlayerCreationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(80, 149, 157, 165),
                offset: Offset(0, 3),
                blurRadius: 14)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200.0,
            height: 200.0,
            decoration: const BoxDecoration(
                color: Colors.yellow, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
