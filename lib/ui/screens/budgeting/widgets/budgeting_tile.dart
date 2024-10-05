import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class BudgetingTile extends StatelessWidget {
  final String title;
  final int proportion;
  final double amount;
  final void Function()? onIncrement;
  final void Function()? onDecrement;

  const BudgetingTile(
      {super.key,
      required this.title,
      required this.proportion,
      required this.amount,
      this.onIncrement,
      this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onIncrement,
          child: Transform.rotate(
            angle: 1.571,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 40.0,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        AlphaContainer(
          width: 200.0,
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyles.bold19,
              ),
              Text("${proportion * 10}%", style: TextStyles.bold45),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: amount),
                duration: Durations.medium3,
                builder: (BuildContext context, double value, Widget? child) =>
                    Text(
                  "\$${value.toStringAsFixed(2)}",
                  style: TextStyles.bold30,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        GestureDetector(
          onTap: onDecrement,
          child: Transform.rotate(
            angle: -1.571,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 40.0,
            ),
          ),
        ),
      ],
    );
  }
}
