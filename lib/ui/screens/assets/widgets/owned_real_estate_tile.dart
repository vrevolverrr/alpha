import 'package:alpha/extensions.dart';
import 'package:alpha/logic/real_estate_logic.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:flutter/material.dart';

class OwnedRealEstateTile extends StatelessWidget {
  final RealEstate realEstate;

  const OwnedRealEstateTile({super.key, required this.realEstate});

  @override
  Widget build(BuildContext context) {
    return AlphaContainer(
      width: 500.0,
      child: Column(
        children: [
          Container(
            width: 500.0,
            height: 200.0,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          Text(
            realEstate.name,
            style: TextStyles.bold28,
          ),
          const SizedBox(height: 10.0),
          Text(
            "Property Value",
            style: TextStyles.bold19.copyWith(color: Colors.black87),
          ),
          Text(realEstate.propertyValue.prettyCurrency,
              style: TextStyles.bold35),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Outstanding Balance",
                    style: TextStyles.bold19.copyWith(color: Colors.black87),
                  ),
                  Text(
                    realEstate.loanAmount.prettyCurrency,
                    style: TextStyles.bold32,
                  ),
                ],
              ),
              const SizedBox(width: 30.0),
              Column(
                children: [
                  Text(
                    "Remaining Term",
                    style: TextStyles.bold19.copyWith(color: Colors.black87),
                  ),
                  Text(
                    "${realEstate.repaymentPeriod} rounds",
                    style: TextStyles.bold32,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
