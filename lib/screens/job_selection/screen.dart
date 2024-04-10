import 'package:alpha/model/job.dart';
import 'package:alpha/model/player.dart';
import 'package:alpha/screens/job_prospect/screen.dart';
import 'package:alpha/utils/helper.dart';
import 'package:alpha/screens/job_selection/bottom_floating_bar.dart';
import 'package:alpha/screens/job_selection/job_tile.dart';
import 'package:alpha/widgets/alpha_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobSelectionScreen extends StatefulWidget {
  final Player player;

  const JobSelectionScreen({super.key, required this.player});

  @override
  State<JobSelectionScreen> createState() => _JobSelectionScreenState();
}

class _JobSelectionScreenState extends State<JobSelectionScreen>
    with ChangeNotifier {
  Job? selectedJob;
  ValueNotifier<bool> invalid = ValueNotifier(false);

  Column buildJobGrid() {
    List<Widget> row = [];
    List<Widget> column = [];

    for (int i = 0; i < 2; i++) {
      for (Job job in Job.values) {
        if (job.tier != 0) continue;

        if (i == 0 && widget.player.education.lessThan(job.education)) {
          continue;
        }
        if (i == 1 &&
            widget.player.education.greaterThanOrEqualsTo(job.education)) {
          continue;
        }

        row.add(GestureDetector(
          onTap: widget.player.education.greaterThanOrEqualsTo(job.education)
              ? () => {
                    setState(() {
                      selectedJob = job;
                    })
                  }
              : () {
                  invalid.value = true;
                  invalid.notifyListeners();
                },
          onLongPress: job.hasProgression
              ? () => {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            JobProspectScreen(job: job)))
                  }
              : null,
          child: Hero(
            tag: job.jobTitle,
            child: JobTile(
                job: job,
                eligible: widget.player.education
                    .greaterThanOrEqualsTo(job.education),
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
  void dispose() {
    invalid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AlphaAppBar(title: "Select Job"),
      body: Stack(
        children: [
          SingleChildScrollView(child: buildJobGrid()),
          AnimatedBottomFloatingBar(
              invalidNotifier: invalid,
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
                      fontWeight: FontWeight.w600)))
        ],
      ),
    );
  }
}
