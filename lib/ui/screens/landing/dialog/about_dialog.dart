import 'package:alpha/assets.dart';
import 'package:alpha/main.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:flutter/material.dart';

AlphaDialogBuilder buildAboutGameDialog(
    BuildContext context, void Function() onTapConfirm) {
  return AlphaDialogBuilder(
    title: "About Cashflow",
    child: const AboutGameDialog(),
    next: DialogButtonData.confirm(onTap: onTapConfirm),
  );
}

class AboutGameDialog extends StatelessWidget {
  const AboutGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    /// If selection is to skip education

    return Column(
      children: <Widget>[
        SizedBox(
            width: 300.0,
            height: 90.0,
            child: Image.asset(AlphaAsset.logoIIC.path)),
        const Text(
          "version $version",
          style: TextStyles.medium15,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10.0),
        const Text("Built by the IIC Software Operations Team",
            style: TextStyles.medium17)
      ],
    );
  }
}
