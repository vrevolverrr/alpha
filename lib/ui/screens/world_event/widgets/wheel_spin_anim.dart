import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WheelSpinAnimation extends StatelessWidget {
  final AnimationController controller;
  const WheelSpinAnimation({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      "assets/anim/wheel_spin.json",
      width: 600,
      height: 600,
      controller: controller,
      frameRate: FrameRate.composition,
      renderCache: RenderCache.drawingCommands,
    );
  }
}
