import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:flutter/material.dart';

class EducationSelectionScreen extends StatefulWidget {
  const EducationSelectionScreen({super.key});

  @override
  State<EducationSelectionScreen> createState() =>
      _EducationSelectionScreenState();
}

class _EducationSelectionScreenState extends State<EducationSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Choose Education",
      next: Builder(
          builder: (BuildContext context) => const AlphaButton(
                width: 230.0,
                title: "Confirm",
              )),
      children: const <Widget>[
        SizedBox(height: 60.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AlphaAnimatedContainer(
                width: 400.0, height: 500.0, child: Placeholder()),
            SizedBox(width: 40.0),
            AlphaAnimatedContainer(
                width: 400.0, height: 500.0, child: Placeholder())
          ],
        )
      ],
    );
  }
}
