import 'package:alpha/styles.dart';
import 'package:flutter/material.dart';

class RealEstateSelectionLandingdialog extends StatelessWidget {
  const RealEstateSelectionLandingdialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 580.0,
      child: Column(
        children: [
          Text(
            "Purchasing a real estate is a long-term investment that can provide a decent income stream, "
            "as the value of the property appreciates every round. You can take a mortgage "
            "if your cash flow per round is sufficient to cover the loan repayments.",
            style: TextStyles.medium22,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
