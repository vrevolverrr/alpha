import 'package:alpha/model/player.dart';
import 'package:flutter/material.dart';

class HorizontalPlayerCard extends StatelessWidget {
  final Player player;

  const HorizontalPlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 440.0,
      height: 150.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.02),
                offset: Offset(0, 1),
                spreadRadius: 3.0,
                blurRadius: 3.0),
            BoxShadow(
                color: Color.fromRGBO(27, 31, 35, 0.15),
                offset: Offset(0, 0),
                spreadRadius: 0,
                blurRadius: 1.0)
          ]),
      child: Row(
        children: [
          const SizedBox(width: 25.0),
          Container(
            width: 100.0,
            height: 100.0,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.amber),
          ),
          const SizedBox(width: 25.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player.name,
                style: const TextStyle(
                    fontSize: 21.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2.0),
              Row(
                children: [
                  Text(
                    "💵 ${player.savings.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(width: 30.0),
                ],
              ),
              const SizedBox(height: 2.0),
              Row(
                children: [
                  Text(
                    "🩷 ${player.happiness}",
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(width: 15.0),
                  Text(
                    "🎓 ${player.education.title}",
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
