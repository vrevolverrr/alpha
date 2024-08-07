import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class GameTileSelectionCard extends StatelessWidget {
  final String title;
  final bool selected;
  const GameTileSelectionCard(
      {super.key, required this.title, this.selected = false});

  // Animation onfigurations
  final _animDuration = const Duration(milliseconds: 120);
  final _animCurve = Curves.decelerate;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: selected ? 1.04 : 1.0,
      duration: _animDuration,
      child: AnimatedSlide(
        offset: selected ? const Offset(0.0, -0.04) : Offset.zero,
        duration: _animDuration,
        curve: _animCurve,
        child: AlphaAnimatedContainer(
            width: 240.0,
            height: 250.0,
            duration: _animDuration,
            curve: _animCurve,
            shadowOffset: selected ? const Offset(4.0, 5.0) : null,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyles.bold30,
              ),
            )),
      ),
    );
  }
}
