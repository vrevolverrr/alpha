import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/education/education_selection_screen.dart';
import 'package:flutter/material.dart';

AlphaDialogBuilder buildEducationConfirmDialog(BuildContext context,
    EducationSelection selection, void Function() onTapConfirm) {
  return AlphaDialogBuilder(
    title: "Confirm Selection",
    child: EducationConfirmDialog(selection),
    cancel: DialogButtonData.cancel(context),
    next: DialogButtonData.confirm(onTap: onTapConfirm),
  );
}

class EducationConfirmDialog extends StatelessWidget {
  final EducationSelection selection;

  const EducationConfirmDialog(this.selection, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Are you sure you want to ${selection.title.toLowerCase()}?",
          style: TextStyles.bold28,
        ),
        const SizedBox(height: 6.0),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "You will receive ",
                style: TextStyles.medium22
                    .copyWith(fontFamily: "MazzardH", color: Colors.black),
              ),
              TextSpan(
                text: "+${selection.xp} XP",
                style: TextStyles.medium22
                    .copyWith(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    " skill points by pursuing this. The XP gain will take effect immediately.",
                style: TextStyles.medium22
                    .copyWith(fontFamily: "MazzardH", color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
