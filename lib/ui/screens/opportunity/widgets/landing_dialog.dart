import 'package:alpha/styles.dart';
import 'package:flutter/material.dart';

class OpportunityLandingDialog extends StatelessWidget {
  const OpportunityLandingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        constraints: const BoxConstraints(
          maxWidth: 1250.0, // Limit the width
        ),
        child: Column(
          children: [
            Text(
              "Draw an Opportunity Tile to see what chance or challenge awaits. It could bring you luck, test your knowledge, or even lighten or tighten your wallet.",
              style: TextStyles.bold40,
            ),
            const SizedBox(height: 20.0), // Space between sections
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Center-align the section
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "Here's what you might find:",
                  style: TextStyles.bold40,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0), // Space before the list
                Text(
                  "• Quiz",
                  style: TextStyles.bold40,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Text(
                  "• CDC Vouchers",
                  style: TextStyles.bold40,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Text(
                  "• Get Fined",
                  style: TextStyles.bold40,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Text(
                  "• Win the Lottery",
                  style: TextStyles.bold40,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 25.0), // Bottom padding
          ],
        ),
      ),
    );
  }
}
