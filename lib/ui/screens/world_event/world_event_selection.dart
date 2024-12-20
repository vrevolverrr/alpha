import 'package:alpha/extensions.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:alpha/ui/screens/world_event/widgets/landing_dialog.dart';
import 'package:alpha/ui/screens/world_event/widgets/wheel_spin_anim.dart';
import 'package:flutter/material.dart';

class WheelSpinScreen extends StatefulWidget {
  const WheelSpinScreen({super.key});

  @override
  State<WheelSpinScreen> createState() => _WheelSpinScreenState();
}

class _WheelSpinScreenState extends State<WheelSpinScreen>
    with SingleTickerProviderStateMixin {
  String economicState(String multiplier) {
    if (multiplier == '1.0x') {
      return "NORMAL: ";
    }
    if (multiplier == '1.5x') {
      return "BOOMING: ";
    }
    if (multiplier == '0.8x') {
      return "RECESSION: ";
    }
    if (multiplier == '0.6x') {
      return "DEPRESSION: ";
    }
    return '';
  }

  String wheel = gameManager.wheelSpin();
  String? econState; // Nullable variable

  @override
  void initState() {
    super.initState();

    econState = economicState(wheel);
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "",
        landingDialog: AlphaDialogBuilder.dismissable(
            title: "Economic State",
            dismissText: "Continue",
            width: 350,
            child: WorldEventLandingDialog(
              economicState: econState,
              multiplierValue: wheel,
            )),
        onTapBack: () => Navigator.of(context).pop(),
        next: Builder(
          builder: (BuildContext context) => AlphaButton(
            width: 230.0,
            title: "Confirm",
            onTap: () => context.navigateAndPopTo(const DashboardScreen()),
          ),
        ),
        children: <Widget>[
          // Builder(
          //     builder: (BuildContext context) => AlphaButton(
          //           width: 265.0,
          //           height: 70.0,
          //           title: "WHEEL SPIN",
          //           icon: Icons.arrow_upward_rounded,
          //           onTap: () => _handleWheelSpin(context),
          //           disabled: _hasSpinWheel,
          //           onTapDisabled: () => _wheelSpinInProgress(context),
          //         ))
        ]);
  }

  // void _wheelSpinInProgress(BuildContext context) {
  //   AlphaScaffold.of(context)
  //       .showSnackbar(message: "✋🏼 The wheel is already spinning");
  // }

  // void _handleWheelSpin(BuildContext context) {
  //   String wheel = gameManager.wheelSpin();

  //   AlphaDialogBuilder dialog = AlphaDialogBuilder(
  //       title: "Economic State",
  //       next: DialogButtonData(
  //           width: 240.0,
  //           title: "Continue",
  //           onTap: () {
  //             context.dismissDialog();
  //             context.navigateAndPopTo(const DashboardScreen());
  //           }),
  //       child: Column(
  //         children: <Widget>[
  //           Text(
  //             economicState(wheel),
  //             style: TextStyles.medium36,
  //           ),
  //           SizedBox(
  //               height: 150.0,
  //               child: Text(
  //                 wheel.toString(),
  //                 style: const TextStyle(fontSize: 130.0, height: 0.0),
  //               ))
  //         ],
  //       ));

  //   setState(() {
  //     _hasSpinWheel = true;
  //     _animController.reset();
  //     _animController.forward().then((_) => context.showDialog(dialog));
  //   });
  // }

  // @override
  // void initState() {
  //   // initialize [AnimationController] and put wheel at end of animation
  //   _animController = AnimationController(
  //       vsync: this, duration: const Duration(milliseconds: 0));
  //   _animController.forward();
  //   _animController.duration = const Duration(milliseconds: 2500);
  //   super.initState();
  // }
}
