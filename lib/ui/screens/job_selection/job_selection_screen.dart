import 'package:alpha/extensions.dart';
import 'package:alpha/logic/job.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:alpha/ui/screens/job_selection/widget/job_selection_card.dart';
import 'package:alpha/utils.dart';
import 'package:flutter/material.dart';

class JobSelectionScreen extends StatefulWidget {
  const JobSelectionScreen({super.key});

  @override
  State<JobSelectionScreen> createState() => _JobSelectionScreenState();
}

class _JobSelectionScreenState extends State<JobSelectionScreen> {
  final GlobalKey<AlphaScaffoldState> key = GlobalKey<AlphaScaffoldState>();
  Job _selectdJob = Job.unemployed;

  /// This function maps each Job to a [JobSelectionCard] widget and computes
  /// the eligibility and whether or not the card has been selected
  /// This function is called on each build()
  List<JobSelectionCard> _mapJobCards() => Job.values
      // TODO optimise performance by only sorting once during initState
      .where((job) => job.tier == 0) // only show entry-level jobs
      .map((job) => JobSelectionCard(
          // map each [Job] enum to a [JobSelectionCard] widget
          job: job,
          selected: job == _selectdJob,
          eligible: context.gameState.activePlayer.education
              .greaterThanOrEqualsTo(job
                  .education))) // eliglbe iff player meets education requirements
      .toList()
    // sort by eligible first, then by salary
    ..sort((JobSelectionCard a, JobSelectionCard b) {
      // sort by eligibility first
      if ((a.eligible && !b.eligible) || (!a.eligible && b.eligible)) {
        return (a.eligible && !b.eligible) ? -1 : 1;
      }

      // then sort by salary desc
      return (b.job.jobSalary - a.job.jobSalary).toInt();
    });

  void _confirmJobSelection(BuildContext context) {
    /// This function maps to the action of the CONFIRM button of the screen
    final AlphaDialogBuilder dialog = AlphaDialogBuilder(
        title: "Confirm Job",
        child: Column(
          children: <Widget>[
            Text(
              "You have chosen to work as ${singularArticle(_selectdJob.jobTitle)}.",
              style: const TextStyle(fontSize: 22.0),
            ),
            const SizedBox(height: 2.0),
            const Text("Are you sure?", style: TextStyle(fontSize: 22.0)),
            const SizedBox(height: 25.0),
            JobDescriptionTagCollection(job: _selectdJob, eligible: true),
            const SizedBox(height: 50.0),
          ],
        ),
        cancel: DialogButtonData.cancel(context),
        next: DialogButtonData.confirm(onTap: _confirmJobInDialog));

    context.showDialog(dialog);
  }

  void _confirmJobInDialog() {
    // This function maps to the CONFIRM button of the alert dialog
    context.gameState.activePlayer.updateJob(_selectdJob);
    context.navigateAndPopTo(const DashboardScreen());
  }

  void _showIneligibleMessage(BuildContext context) {
    /// This function is called when an ineligible card is pressed
    context.showSnackbar(
        message: "✋🏼 Your education level is not qualified for that job.");
  }

  @override
  void initState() {
    super.initState();

    /// Display snackbar on state initialisaiton, find alternative that
    /// do not use GlobalKey if possible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
          const Duration(milliseconds: 500),
          () => key.currentState!.showSnackbar(
              message: "🎯 Choose a career you would like to pursue",
              duration: const Duration(seconds: 3)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        key: key,
        title: "Choose a Job",
        onTapBack: () => Navigator.of(context).pop(),
        next: Builder(
            builder: (BuildContext context) => AlphaButton(
                width: 230.0,
                title: "Confirm",
                onTap: () => _confirmJobSelection(context))),
        children: <Widget>[
          const SizedBox(height: 5.0),
          Expanded(
            child: Builder(
              builder: (BuildContext context) => GridView.count(
                childAspectRatio: 0.78,
                padding: const EdgeInsets.symmetric(
                    horizontal: 60.0, vertical: 50.0),
                mainAxisSpacing: 50.0,
                crossAxisSpacing: 50.0,
                crossAxisCount: 3,
                children: _mapJobCards()
                    .map((JobSelectionCard card) => GestureDetector(
                          onTap: card.eligible
                              ? () => setState(() => _selectdJob = card.job)
                              : () => _showIneligibleMessage(context),
                          child: card,
                        ))
                    .toList(),
              ),
            ),
          )
        ]);
  }
}
