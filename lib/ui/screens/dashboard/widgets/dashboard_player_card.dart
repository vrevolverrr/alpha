import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class DashboardPlayerCard extends StatelessWidget {
  final String playerName;

  const DashboardPlayerCard({super.key, required this.playerName});

  @override
  Widget build(BuildContext context) {
    return AlphaContainer(
      width: 200.0,
      height: 230.0,
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          SizedBox(
            width: 130.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                "assets/images/player_default.png",
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 2.0),
            width: 140.0,
            height: 35.0,
            decoration: BoxDecoration(
                color: const Color(0xffBFF3FF),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: Colors.black, width: 2.0)),
            child: Text(
              playerName,
              style: TextStyles.bold17,
            ),
          )
        ],
      ),
    );
  }
}
