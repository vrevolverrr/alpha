import 'package:alpha/ui/screens/gametile_selection/screen.dart';
import 'package:alpha/ui/common/bottom_floating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiceRollScreen extends StatelessWidget {
  final int rollNumber;

  const DiceRollScreen(this.rollNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("You rolled",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 50.0)),
          Text(
            rollNumber.toString(),
            style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 200.0),
          ),
          AnimatedBottomFloatingBar(
              selected: true,
              text: const Text(
                "✋ Please move your player on the board before proceeding",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
              ),
              onProceed: () => Navigator.of(context).push(CupertinoPageRoute(
                  builder: (BuildContext context) =>
                      const GameTileSelectionScreen()))),
        ],
      ),
    ));
  }
}
