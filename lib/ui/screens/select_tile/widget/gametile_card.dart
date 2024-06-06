import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class GameTileSelectionCard extends StatefulWidget {
  final bool selected;
  const GameTileSelectionCard({super.key, this.selected = false});

  @override
  State<GameTileSelectionCard> createState() => _GameTileSelectionCardState();
}

class _GameTileSelectionCardState extends State<GameTileSelectionCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: widget.selected ? const Offset(0.0, 5.0) : Offset.zero,
      duration: Durations.long4,
      child: AlphaAnimatedContainer(
          width: 240.0, height: 240.0, child: Container()),
    );
  }
}
