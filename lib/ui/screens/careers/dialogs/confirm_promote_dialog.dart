import 'package:alpha/logic/data/careers.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:flutter/material.dart';

AlphaDialogBuilder buildConfirmPromoteDialog(
    BuildContext context, Job nextJob, void Function() onTapConfirm) {
  return AlphaDialogBuilder(
    title: "Confirm Promotion",
    child: const Column(
      children: <Widget>[
        Text(
          "Are you sure you want to be promoted?",
          style: TextStyles.bold24,
        ),
        SizedBox(height: 6.0),
        SizedBox(
          width: 520.0,
          child: Text(
            "You will still receive your promoted salary in the next round.",
            textAlign: TextAlign.center,
            style: TextStyles.medium18,
          ),
        ),
        SizedBox(height: 60.0),
      ],
    ),
    cancel: DialogButtonData.cancel(context),
    next: DialogButtonData.confirm(onTap: onTapConfirm),
  );
}
