import 'package:alpha/styles.dart';
import 'package:flutter/material.dart';

class WorldEventLandingDialog extends StatelessWidget {
  final economicState;
  final multiplierValue;
  const WorldEventLandingDialog(
      {super.key, required this.economicState, required this.multiplierValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 530.0,
          child: Column(children: <Widget>[
            Text(
              economicState,
              style: TextStyles.medium36,
            ),
            SizedBox(
                height: 150.0,
                child: Text(
                  multiplierValue.toString(),
                  style: const TextStyle(fontSize: 130.0, height: 0.0),
                ))
          ]),
        ),
        const SizedBox(
          height: 25.0,
        )
      ],
    );
  }
}
