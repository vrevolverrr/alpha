import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:flutter/material.dart';

AlphaDialogBuilder buildConfirmResignDialog(
    BuildContext context, void Function() onTapConfirm) {
  return AlphaDialogBuilder(
    title: "Confirm Resign",
    child: const ConfirmResignDialog(),
    cancel: DialogButtonData.cancel(context),
    next: DialogButtonData.confirm(onTap: onTapConfirm),
  );
}

class ConfirmResignDialog extends StatelessWidget {
  const ConfirmResignDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Text(
          "Are you sure you want to resign?",
          style: TextStyles.bold28,
        ),
        SizedBox(height: 6.0),
        SizedBox(
          width: 520.0,
          child: Text(
            "You will still receive your salary for this round and be able to select a new job after resigning.",
            textAlign: TextAlign.center,
            style: TextStyles.medium22,
          ),
        ),
        SizedBox(height: 60.0),
      ],
    );
  }
}
