import 'package:alpha/styles.dart';
import 'package:flutter/material.dart';

class PlayerStatCard extends StatelessWidget {
  /// The title of the stat card
  final String title;

  /// The leading emoji of the stat card
  final String emoji;

  /// The value of the stat
  final String value;

  /// Width to use for the stat value
  final double valueWidth;

  const PlayerStatCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.value,
    this.valueWidth = 135.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(color: Colors.black, width: 3.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black, offset: Offset(1.5, 1.5))
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(emoji, style: TextStyles.black18),
          const SizedBox(width: 5.0),
          Text(title, style: TextStyles.bold16),
          const SizedBox(width: 6.0),
          Expanded(
            child: Text(value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00734A),
                    fontSize: 18.0)),
          )
        ],
      ),
    );
  }
}
