import 'package:alpha/styles.dart';
import 'package:flutter/material.dart';

class EducationLandingDialog extends StatelessWidget {
  const EducationLandingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 580.0,
      child: Column(
        children: [
          Text(
            "Education is the key to success in the early game. Pursue a degree or learn an online course to "
            "improve your skill level and unlock more job opportunities and career progression.",
            style: TextStyles.medium22,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }
}
