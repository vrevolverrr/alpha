import 'package:alpha/styles.dart';
import 'package:flutter/material.dart';

class InvestmentsLandingDialog extends StatelessWidget {
  const InvestmentsLandingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 530.0,
          child: Text(
            "Strategically invest in a diverse range of stocks within various sectors, "
            "each with its own risk level. Stocks with higher risk can yield "
            "greater returns, but may result in greater losses. ESG stocks increase "
            "your ESG score, but may have lower returns.",
            style: TextStyles.medium20,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 25.0,
        )
      ],
    );
  }
}
