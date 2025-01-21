import 'package:alpha/assets.dart';
import 'package:alpha/extensions.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/landing/dialog/about_dialog.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  final void Function()? onTapNext;
  const LandingScreen({super.key, this.onTapNext});

  void _handleShowAboutDialog(BuildContext context) {
    context.showDialog(buildAboutGameDialog(context, () {
      context.dismissDialog();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(title: "", children: [
      Expanded(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 30.0),
                SizedBox(
                    width: 800.0,
                    height: 450.0,
                    child: Image.asset(AlphaAsset.logoCashflow.path)),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AlphaButton(
                      width: 340.0,
                      title: "Start Game",
                      color: AlphaColors.green,
                      onTap: onTapNext,
                    ),
                    const SizedBox(width: 20.0),
                    Builder(
                        builder: (context) => AlphaButton(
                              width: 240.0,
                              title: "About",
                              onTap: () => _handleShowAboutDialog(context),
                            ))
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                  width: 140.0,
                  height: 140.0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
                    child: Image.asset(AlphaAsset.logoNcf.path),
                  )),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "version 0.2.1 Build 1",
                    style: TextStyles.medium18,
                  )),
            )
          ],
        ),
      )
    ]);
  }
}
