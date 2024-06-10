import 'package:alpha/extensions.dart';
import 'package:alpha/logic/enums/education.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:alpha/ui/screens/education_selection/widget/education_card.dart';
import 'package:flutter/material.dart';

class EducationSelectionScreen extends StatefulWidget {
  const EducationSelectionScreen({super.key});

  @override
  State<EducationSelectionScreen> createState() =>
      _EducationSelectionScreenState();
}

class _EducationSelectionScreenState extends State<EducationSelectionScreen> {
  bool _selectedEducation = true;

  Education getNextDegree() =>
      context.gameState.activePlayer.getNextEducation();

  Education getCurrentDegree() =>
      context.gameState.activePlayer.getNextEducation();

  void _confirmSelectionInDialog() {
    // TODO update education
    context.navigateAndPopTo(const DashboardScreen());
  }

  void _confirmSelection(BuildContext context) {
    final AlphaDialogBuilder dialog = AlphaDialogBuilder(
        title: "Confirm Education",
        child: Column(
          children: <Widget>[
            Text(
              "You have chosen to pursue your ${getNextDegree().title} degree.",
              style: const TextStyle(fontSize: 22.0),
            ),
            const SizedBox(height: 2.0),
            const Text("The degree will be awarded after 4 turns.",
                style: TextStyle(fontSize: 22.0)),
            const SizedBox(height: 8.0),
            const Text("Are you sure?", style: TextStyle(fontSize: 22.0)),
            const SizedBox(height: 40.0),
          ],
        ),
        cancel: DialogButtonData.cancel(context),
        next: DialogButtonData.confirm(onTap: _confirmSelectionInDialog));

    context.showDialog(dialog);
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Choose Education",
      landingMessage: "🎓 Choose whether or not to pursue an education.",
      onTapBack: () => Navigator.of(context).pop(),
      next: Builder(
          builder: (BuildContext context) => AlphaButton(
                width: 230.0,
                title: "Confirm",
                onTap: () => _confirmSelection(context),
              )),
      children: <Widget>[
        const SizedBox(height: 65.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () => setState(() => _selectedEducation = true),
                child: EducationCard(
                    title: "${getNextDegree().title} Degree",
                    description:
                        "Pay \$5,000 to get educated and receive a ${getNextDegree().title} degree after 4 turns",
                    selected: _selectedEducation,
                    affordable: false)),
            const SizedBox(width: 40.0),
            GestureDetector(
                onTap: () => setState(() => _selectedEducation = false),
                child: EducationCard(
                  title: "No Degree",
                  description:
                      "Maintain current education level as ${getCurrentDegree().title}",
                  selected: !_selectedEducation,
                ))
          ],
        )
      ],
    );
  }
}
