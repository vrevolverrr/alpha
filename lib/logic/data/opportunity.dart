import 'dart:ui';

import 'package:alpha/assets.dart';
import 'package:flutter/cupertino.dart';

enum Opportunity {
  lottery(
      titleName: "YOU'VE WON THE LOTTERY!",
      description:
          "Jackpot! Luck is on your side, and you’ve won the lottery! Collect \$5,000 and let the good times roll.",
      asset: AlphaAssets.opportunityMoneyBag,
      colorPrimary: Color(0xFFA7DBD8),
      colorSecondary: Color.fromARGB(255, 130, 195, 191)),

  fined(
      titleName: "YOU GOT FINED!",
      description:
          "Oops, you’ve hit a bump in the road. You’ve been fined, costing you \$1,000. It’s a setback, but remember—it’s just a part of life’s journey!",
      asset: AlphaAssets.opportunityFined,
      colorPrimary: Color(0xFFFFE68B),
      colorSecondary: Color.fromARGB(255, 247, 219, 118)),

  quiz(
      titleName: "QUIZ TIME!",
      description:
          "Time to flex your brainpower! Answer correctly to gain intelligence points and boost your happiness. Knowledge is power, after all!",
      asset: AlphaAssets.opportunityQuiz,
      colorPrimary: Color(0xFFC7B7F3),
      colorSecondary: Color.fromARGB(255, 171, 149, 230)),

  voucher(
      titleName: "YOU'VE WON CDC VOUCHER!",
      description:
          "A little something to brighten your day! Redeem your CDC voucher to instantly boost your happiness by +10. Enjoy some guilt-free shopping or treat yourself!",
      asset: AlphaAssets.opportunityCdcVoucher,
      colorPrimary: Color(0xFFFFC0CD),
      colorSecondary: Color(0xFFEFADAE));

  const Opportunity(
      {required this.titleName,
      required this.description,
      required this.asset,
      required this.colorPrimary,
      required this.colorSecondary});

  final String titleName;
  final String description;
  final AlphaAssets asset;
  final Color colorPrimary;
  final Color colorSecondary;
}
