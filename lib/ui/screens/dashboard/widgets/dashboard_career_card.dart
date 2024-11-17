import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class DashboardCurrentCareerCard extends StatelessWidget {
  final Player player;

  const DashboardCurrentCareerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        AlphaContainer(
            width: 200.0,
            height: 230.0,
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Center(
                child: Text(
              "WIP!!\n${player.education.level.toString()}",
              textAlign: TextAlign.center,
              style: TextStyles.medium15,
            ))),
        Container(
          alignment: Alignment.center,
          transform: Matrix4.translation(Vector3(0, -20.0, 0)),
          padding: const EdgeInsets.only(top: 4.0, right: 2.0),
          width: 150.0,
          height: 40.0,
          decoration: BoxDecoration(
              color: const Color(0xffFFBFCA),
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: Colors.black, width: 3.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Colors.black, offset: Offset(1.5, 1.5))
              ]),
          child: const Text(
            "Career",
            style: TextStyles.bold18,
          ),
        ),
      ],
    );
  }
}
