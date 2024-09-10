import 'package:alpha/extensions.dart';
import 'package:alpha/logic/data/education.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:alpha/ui/screens/education_selection/widgets/education_card.dart';
import 'package:flutter/material.dart';

class EducationSelectionScreen extends StatefulWidget {
  const EducationSelectionScreen({super.key});

  @override
  State<EducationSelectionScreen> createState() =>
      _EducationSelectionScreenState();
}

class _EducationSelectionScreenState extends State<EducationSelectionScreen> {
  bool _selectedPursue = false;
  bool _selectedOnline = false;

  EducationDegree getNextDegree() => activePlayer.education.getNext();

  EducationDegree getCurrentDegree() => activePlayer.education.getNext();

  void _confirmSelectionInDialog() {
    // TODO update education
    context.navigateAndPopTo(const DashboardScreen());
  }

  void _confirmSelection(BuildContext context) {
    final AlphaDialogBuilder dialog = AlphaDialogBuilder(
        title: "Confirm Selection",
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "Pursue ${getNextDegree().title}",
                style: TextStyles.bold25,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Ensures the row sizes itself to its content
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "💵",
                        style: TextStyle(
                          fontSize: 35.0, // Larger font size for the emoji
                        ),
                      ),
                      SizedBox(
                          width: 8.0), // Add spacing between emoji and text
                      Text("-\$50000.00",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30.0,
                              color: Color.fromARGB(255, 230, 45, 32))),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  "+500xp",
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 88, 231, 93)),
                ),
                SizedBox(
                  width: 60,
                ),
              ],
            ),
            const SizedBox(height: 40),
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
      children: <Widget>[
        const SizedBox(height: 35.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(builder: (context) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPursue = true;
                      _selectedOnline = false;
                    });
                    _confirmSelection(context);
                  },
                  child: EducationCard(
                      title: "Pursue ${getNextDegree().title} Degree",
                      description:
                          "Increase skill and unlock more job opportunities",
                      cost: 50000,
                      xp: 500,
                      selected: _selectedPursue,
                      affordable: false));
            }),
            const SizedBox(height: 50.0),
            Builder(builder: (context) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOnline = true;
                      _selectedPursue = false;
                    });
                    _confirmSelection(context);
                  },
                  child: EducationCard(
                    title: "Online Course",
                    description: "Increase your skill",
                    cost: 20000,
                    xp: 200,
                    selected: _selectedOnline,
                  ));
            })
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          height: 1,
          width: 450,
          color: const Color.fromARGB(255, 198, 198, 198),
        ),
        const SizedBox(
          height: 50,
        ),
        Builder(
            builder: (BuildContext context) => AlphaButton(
                  width: 300.0,
                  title: "Skip",
                  onTap: () => _confirmSelection(context),
                )),
      ],
    );
  }
}
