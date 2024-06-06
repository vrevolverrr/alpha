import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class GameTileSelectionCard extends StatefulWidget {
  final String title;
  final bool selected;
  const GameTileSelectionCard(
      {super.key, required this.title, this.selected = false});

  @override
  State<GameTileSelectionCard> createState() => _GameTileSelectionCardState();
}

class _GameTileSelectionCardState extends State<GameTileSelectionCard> {
  // Animation onfigurations
  final _animDuration = const Duration(milliseconds: 120);
  final _animCurve = Curves.decelerate;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: widget.selected ? 1.04 : 1.0,
      duration: _animDuration,
      child: AnimatedSlide(
        offset: widget.selected ? const Offset(0.0, -0.04) : Offset.zero,
        duration: _animDuration,
        curve: _animCurve,
        child: AlphaAnimatedContainer(
            width: 240.0,
            height: 250.0,
            duration: _animDuration,
            curve: _animCurve,
            offset: widget.selected ? const Offset(4.0, 5.0) : null,
            child: Center(
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30.0, fontWeight: FontWeight.w700),
              ),
            )),
      ),
    );
  }
}
