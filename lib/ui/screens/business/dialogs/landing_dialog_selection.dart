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
          "Business earnings are credited after each round, and are influenced by "
          "the economic cycle, market trends, and number of competitors. "
          "Businesses with higher ESG rating typically have higher initial costs but "
          "have lower operational costs, which can lead to higher profits in the long run. ",
          style: TextStyles.medium23,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
