import 'package:alpha/model/player.dart';
import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  final Player player;

  const PlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.0,
      height: 300.0,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(60, 149, 157, 165),
                offset: Offset(0, 3),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140.0,
            height: 140.0,
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            player.name,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6.0),
          Text(
            "💵 ${player.savings.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 6.0),
          Text(
            "🩷 ${player.happiness}",
            style: const TextStyle(fontSize: 20.0),
          )
        ],
      ),
    );
  }
}
