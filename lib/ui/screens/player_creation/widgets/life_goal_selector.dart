import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class LifeGoalSelector extends StatelessWidget {
  final PlayerLifeGoal goal;
  final bool selected;

  const LifeGoalSelector(
      {super.key, required this.goal, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: selected ? 1.08 : 1.0,
      duration: Durations.short3,
      curve: Curves.easeInOut,
      child: const AlphaContainer(
        width: 190.0,
        height: 210.0,
      ),
    );
  }
}
