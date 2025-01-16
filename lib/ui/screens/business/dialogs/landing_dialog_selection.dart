import 'package:alpha/styles.dart';
import 'package:flutter/material.dart';

class BusinessesLandingDialog extends StatelessWidget {
  const BusinessesLandingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Start your own business to generate revenue.  "
          "Business revenue is influenced by "
          "the economic cycle, market state, and competition. "
          "Higher ESG rated businesses typically have higher initial costs but "
          "have increased revenue potential.",
          style: TextStyles.medium22,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
