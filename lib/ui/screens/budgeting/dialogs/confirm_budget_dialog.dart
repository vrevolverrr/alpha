import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:flutter/material.dart';

AlphaDialogBuilder buildConfirmBudgetDialog(
    BuildContext context, void Function() onTapConfirm) {
  return AlphaDialogBuilder(
    title: "Confirm Budget",
    child: const ConfirmBudgetDialog(),
    cancel: DialogButtonData.cancel(context),
    next: DialogButtonData.confirm(onTap: onTapConfirm),
  );
}

class ConfirmBudgetDialog extends StatelessWidget {
  const ConfirmBudgetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Text(
          "Confirm budget allocation?",
          style: TextStyles.bold28,
        ),
        SizedBox(height: 6.0),
        SizedBox(
          width: 520.0,
          child: Text(
            "Your budget will be applied immediately and you will receive your budgeted bonuses in this round.",
            textAlign: TextAlign.center,
            style: TextStyles.medium22,
          ),
        ),
        SizedBox(height: 60.0),
      ],
    );
  }
}
