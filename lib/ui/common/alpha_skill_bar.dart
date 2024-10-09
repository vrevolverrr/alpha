import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/logic/skills_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:flutter/material.dart';

class AlphaSkillBar extends StatelessWidget {
  final Player player;
  const AlphaSkillBar(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.0,
      height: 45.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(color: Colors.black, width: 3.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black, offset: Offset(1.5, 1.5))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Level ${player.skill.level}",
            style: TextStyles.bold15,
          ),
          Stack(
            children: <Widget>[
              Container(
                width: 280.0,
                height: 12.0,
                decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Colors.black, width: 2.0)),
              ),
              Container(
                width: player.skill.levelPercent * 200.0,
                height: 12.0,
                decoration: BoxDecoration(
                    color: const Color(0xffFF6B6B),
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(color: Colors.black, width: 2.0)),
              ),
            ],
          ),
          SizedBox(
            width: 113.0,
            child: Text(
              "XP ${player.skill.levelExp} / ${SkillLevel.xpPerLevel}",
              textAlign: TextAlign.right,
              style: TextStyles.bold15,
            ),
          )
        ],
      ),
    );
  }
}
