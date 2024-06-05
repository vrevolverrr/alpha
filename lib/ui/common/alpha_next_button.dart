import 'package:alpha/ui/common/alpha_button.dart';
import 'package:flutter/material.dart';

class AlphaNextButton extends StatelessWidget {
  final void Function()? onTap;

  const AlphaNextButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlphaButton(
      width: 185.0,
      height: 70.0,
      title: "Next",
      icon: Icons.arrow_back_rounded,
      onTap: onTap,
    );
  }
}
