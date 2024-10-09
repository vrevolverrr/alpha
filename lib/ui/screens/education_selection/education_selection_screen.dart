import 'package:alpha/extensions.dart';
import 'package:alpha/logic/data/education.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:alpha/ui/screens/dashboard/widgets/dashboard_player_stats.dart';
import 'package:alpha/ui/screens/education_selection/widgets/education_card.dart';
import 'package:flutter/material.dart';

class EducationSelectionScreen extends StatefulWidget {
  const EducationSelectionScreen({super.key});

  @override
  State<EducationSelectionScreen> createState() =>
      _EducationSelectionScreenState();
}

class _EducationSelectionScreenState extends State<EducationSelectionScreen> {
  _EducationSelection? _selection;

  /// All possible education selection options
  final List<_EducationSelection> _selections = [
    _EducationSelection(0,
        title: "Pursue ${activePlayer.education.getNext().title}",
        description:
            "Further your education to significantly improve your skill XP and unlock more job oppurtunities.",
        cost: activePlayer.education.getNext().cost,
        xp: activePlayer.education.getNext().xp,

        /// Pursue degree on activePlayer
        action: () => activePlayer.pursueDegree()),
    _EducationSelection(1,
        title: "Study Online Course",
        description:
            "Study an online course to slightly improve your skill XP.",
        cost: OnlineCourse.basic.cost,
        xp: OnlineCourse.basic.xp,

        /// Pursue online course on activePlayer
        action: () => activePlayer.pursueOnlineCourse()),
    _EducationSelection(2,
        title: "Skip Education",
        description:
            "Skipping education will result in not increasing your skill XP.",
        cost: 0,
        xp: 0,

        /// Skip education, do nothing
        action: () => {}),
  ];

  void _handleNextConfirm(BuildContext context) {
    if (_selection == null) {
      context.showSnackbar(message: "✋🏼 Please select an education choice");
      return;
    }

    AlphaDialogBuilder dialog =
        _buildConfirmDialog(context, _selection!, _handleDialogConfirmation);
    context.showDialog(dialog);
  }

  void _handleDialogConfirmation() {
    _selection!.action(); // At this point, _selection is never null
    context.navigateAndPopTo(const DashboardScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Choose Education",
      landingMessage: "🎓 Choose whether or not to pursue an education.",
      onTapBack: () => Navigator.of(context).pop(),
      next: Builder(
        builder: (context) =>
            AlphaButton.next(onTap: () => _handleNextConfirm(context)),
      ),
      children: <Widget>[
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 20.0),
          ],
        ),
        const SizedBox(height: 30.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 30.0,
          runSpacing: 30.0,
          children: _selections
              .map((selectable) => _buildEducationCardWithGestures(
                  context, selectable, _selection?.index ?? -1))
              .toList(),
        )
      ],
    );
  }

  Widget _buildEducationCardWithGestures(
          BuildContext context, _EducationSelection selection, int current) =>
      GestureDetector(
          onTapDown: (_) => setState(() => _selection = selection),
          onTapCancel: () => setState(() => _selection = selection),
          onTapUp: (_) => setState(() => _selection = selection),
          child: EducationCard(
            title: selection.title,
            description: selection.description,
            cost: selection.cost,
            xp: selection.xp,
            selected: selection.index == current,
          ));
}

AlphaDialogBuilder _buildConfirmDialog(BuildContext context,
        _EducationSelection selection, void Function() onTapConfirm) =>
    AlphaDialogBuilder(
        title: "Confirm Selection",
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                selection.title,
                style: TextStyles.bold25,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "💵",
                        style: TextStyle(
                          fontSize: 35.0,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(selection.cost.prettyCurrency,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30.0,
                              color: Color.fromARGB(255, 230, 45, 32))),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 50,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Text(
                  "+${selection.xp}xp",
                  style: const TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF61D465)),
                ),
                const SizedBox(
                  width: 60,
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
        cancel: DialogButtonData.cancel(context),
        next: DialogButtonData.confirm(onTap: onTapConfirm));

class _EducationSelection {
  final String title;
  final String description;
  final double cost;
  final int xp;
  final int index;
  final void Function() action;

  _EducationSelection(this.index,
      {required this.title,
      required this.description,
      required this.cost,
      required this.xp,
      required this.action});
}
