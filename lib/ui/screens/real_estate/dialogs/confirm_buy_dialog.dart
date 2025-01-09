import 'package:alpha/extensions.dart';
import 'package:alpha/logic/real_estate_logic.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:flutter/material.dart';

AlphaDialogBuilder buildConfirmBuyRealEstateDialog(BuildContext context,
    RealEstate selectedRealEstate, void Function() onTapConfirm) {
  return AlphaDialogBuilder(
    title: "Confirm Purchase",
    child: Column(
      children: <Widget>[
        const Text(
          "Are you sure you want to buy?",
          style: TextStyles.bold24,
        ),
        const SizedBox(height: 10.0),
        Text(
          selectedRealEstate.name,
          style: TextStyles.bold22,
        ),
        const SizedBox(height: 10.0),
        Text(
          selectedRealEstate.downPayment.prettyCurrency,
          style: const TextStyle(
            color: Color(0xFFDF3737),
            fontSize: 48.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    ),
    cancel: DialogButtonData.cancel(context),
    next: DialogButtonData.confirm(onTap: onTapConfirm),
  );
}
