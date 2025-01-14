import 'package:alpha/extensions.dart';
import 'package:alpha/logic/education_logic.dart';
import 'package:alpha/logic/hints_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/common/alpha_skill_bar.dart';
import 'package:alpha/ui/common/alpha_stat_card.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:alpha/ui/screens/education/dialogs/landing_dialog.dart';
import 'package:alpha/ui/screens/education/widgets/education_card.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class EducationSelectionScreen extends StatefulWidget {
  const EducationSelectionScreen({super.key});

  @override
  State<EducationSelectionScreen> createState() =>
      _EducationSelectionScreenState();
}

class _EducationSelectionScreenState extends State<EducationSelectionScreen> {
  _EducationSelection? _selection;
  late final ConfettiController confettiController;

  late final PlayerEducation education =
      educationManager.getEducation(activePlayer);

  /// All possible education selection options
  late final List<_EducationSelection> _selections = [
    _EducationSelection(0,
        title: "Pursue ${education.getNext().title}",
        description:
            "Further your education to significantly improve your skill XP and unlock more job oppurtunities.",
        cost: education.getNext().cost,
        xp: education.getNext().xp,
        action: () => educationManager.pursueNext(activePlayer)),
    _EducationSelection(1,
        title: "Study Online Course",
        description:
            "Study an online course to slightly improve your skill XP.",
        cost: EducationManager.kOnlineCoursePrice,
        xp: EducationManager.kOnlineCourseXP,

        /// Pursue online course on activePlayer
        action: () => educationManager.pursueOnlineCourse(activePlayer)),
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

    AlphaDialogBuilder dialog = _buildConfirmDialog(
        context, _selection!, () => _handleDialogConfirmation(context));

    context.showDialog(dialog);
  }

  void _handleDialogConfirmation(BuildContext context) {
    /// Perform the transaction after a short delay, to make the animation of the
    /// XP bar change visible to the user, basically i'm just lazy
    Future.delayed(Durations.long1,
        () => _selection!.action()); // At this point, _selection is never null

    AlphaDialogBuilder successDialog = _buildSuccessDialog(
        context, () => context.navigateAndPopTo(DashboardScreen()));

    Future.delayed(Durations.short2, () {
      context.showDialog(successDialog);
      confettiController.play();
    });
  }

  void _handleUnaffordable(BuildContext context, String action) {
    context.showSnackbar(message: "✋🏼 You cannot afford to $action.");
  }

  @override
  void initState() {
    confettiController = ConfettiController(duration: Durations.medium4);
    super.initState();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Choose Education",
      landingMessage: "🎓 Choose whether or not to pursue an education.",
      landingDialog: (hintsManager.shouldShowHint(activePlayer, Hint.education))
          ? AlphaDialogBuilder.dismissable(
              title: "Education",
              dismissText: "Continue",
              width: 350.0,
              child: const EducationLandingDialog())
          : null,
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
            PlayerAccountBalanceStatCard(
                accountsManager.getPlayerAccount(activePlayer)),
            const SizedBox(width: 20.0),
            ListenableBuilder(
                listenable: skillManager.getPlayerSkill(activePlayer),
                builder: (context, child) => AlphaSkillBarMedium(
                    skillManager.getPlayerSkill(activePlayer)))
          ],
        ),
        const SizedBox(height: 40.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 30.0,
          runSpacing: 45.0,
          children: _selections
              .map((selectable) => _buildEducationCardWithGestures(
                  context, selectable, _selection?.index ?? -1))
              .toList(),
        )
      ],
    );
  }

  Widget _buildEducationCardWithGestures(
      BuildContext context, _EducationSelection selection, int current) {
    bool affordable =
        accountsManager.getAvailableBalance(activePlayer) >= selection.cost;

    return Builder(
      builder: (BuildContext context) => GestureDetector(
          onTap: affordable
              ? () => setState(() => _selection = selection)
              : () =>
                  _handleUnaffordable(context, selection.title.toLowerCase()),
          child: EducationCard(
            title: selection.title,
            description: selection.description,
            affordable: affordable,
            cost: selection.cost,
            xp: selection.xp,
            selected: selection.index == current,
          )),
    );
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
                height: 20.0,
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
                  const SizedBox(width: 20.0),
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 50.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 40.0),
                  Text(
                    "+${selection.xp}xp",
                    style: const TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF61D465)),
                  ),
                  const SizedBox(width: 60.0),
                ],
              ),
              const SizedBox(height: 40.0),
            ],
          ),
          cancel: DialogButtonData.cancel(context),
          next: DialogButtonData.confirm(onTap: onTapConfirm));

  AlphaDialogBuilder _buildSuccessDialog(
          BuildContext context, void Function() onTapConfirm) =>
      AlphaDialogBuilder(
          title: "Congratulations",
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "You've increased your skill level",
                  style: TextStyles.bold20,
                ),
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                width: 440.0,
                child: FittedBox(
                  child: ListenableBuilder(
                    listenable: skillManager.getPlayerSkill(activePlayer),
                    builder: (context, child) => AlphaSkillBarMedium(
                        skillManager.getPlayerSkill(activePlayer)),
                  ),
                ),
              ),
              const SizedBox(height: 45.0),
            ],
          ),
          next: DialogButtonData(
              title: "Proceed", width: 380.0, onTap: onTapConfirm));
}

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
