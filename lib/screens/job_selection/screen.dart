import 'package:alpha/model/game_state.dart';
import 'package:alpha/model/job.dart';
import 'package:alpha/model/player.dart';
import 'package:alpha/screens/job_prospect/screen.dart';
import 'package:alpha/utils/helper.dart';
import 'package:alpha/screens/job_selection/bottom_floating_bar.dart';
import 'package:alpha/screens/job_selection/job_tile.dart';
import 'package:alpha/widgets/alpha_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobSelectionScreen extends StatefulWidget {
  const JobSelectionScreen({super.key});

  @override
  State<JobSelectionScreen> createState() => _JobSelectionScreenState();
}

class _JobSelectionScreenState extends State<JobSelectionScreen>
    with SingleTickerProviderStateMixin {
  Job? selectedJob;

  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 540));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Column buildJobGrid(Player player) {
    List<Widget> row = [];
    List<Widget> column = [];

    void animateInvalidCallback() {
      if (!animationController.isAnimating) {
        animationController.forward();
      }
    }

    void updateSelectedJobCallback(Job job) =>
        setState(() => selectedJob = job);

    void expandJobProgressionCallback(Job job) =>
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => JobProspectScreen(job: job)));

    for (int i = 0; i < 2; i++) {
      for (Job job in Job.values) {
        // only render tier 0 jobs
        if (job.tier != 0) continue;

        // FIRST PASS : only render eligible jobs, ignore ineligible jobs
        if (i == 0 && player.education.lessThan(job.education)) {
          continue;
        }

        // SECOND PASS : render the ineligible jobs
        if (i == 1 && player.education.greaterThanOrEqualsTo(job.education)) {
          continue;
        }

        row.add(GestureDetector(
          onTap: player.education.greaterThanOrEqualsTo(job.education)
              ? () => updateSelectedJobCallback(job)
              : animateInvalidCallback,
          onLongPress: job.hasProgression
              ? () => expandJobProgressionCallback(job)
              : null,
          child: Hero(
            tag: job.jobTitle,
            child: JobTile(
                job: job,
                eligible: player.education.greaterThanOrEqualsTo(job.education),
                selected: selectedJob != null &&
                    selectedJob!.jobTitle == job.jobTitle),
          ),
        ));

        if (row.length >= 3) {
          column.add(Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 30.0),
                ...row,
                const SizedBox(width: 30.0)
              ]));
          column.add(const SizedBox(height: 30.0));
          row = [];
        }
      }
    }

    for (int i = 0; i < (3 - row.length); i++) {
      row.add(const SizedBox(width: 260.0, height: 320.0));
    }

    column.add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const SizedBox(width: 30.0),
      ...row,
      const SizedBox(width: 30.0)
    ]));

    return Column(
      children: [
        const SizedBox(height: 10.0),
        ...column,
        const SizedBox(height: 140.0)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AlphaAppBar(title: "Select Job"),
      body: Stack(
        children: [
          Consumer<GameState>(
            builder: (context, gameState, child) => SingleChildScrollView(
                child: buildJobGrid(gameState.activePlayer)),
          ),
          AnimatedBottomFloatingBar(
              animationController: animationController,
              selected: selectedJob != null,
              text: (() {
                if (selectedJob == null) {
                  return const Text("Please select a job to apply",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500));
                }

                return RichText(
                    text: TextSpan(
                  text:
                      "You have chose to work as ${isVowel(selectedJob!.jobTitle[0]) ? 'an' : 'a'} ",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                        text: selectedJob != null ? selectedJob!.jobTitle : "",
                        style: const TextStyle(fontWeight: FontWeight.w700))
                  ],
                ));
              })(),
              invalidText: const Text(
                  "You are education level does not qualify for this job",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500)),
              onProceed: () => print("Hello"))
        ],
      ),
    );
  }
}
