import 'package:alpha/model/job.dart';
import 'package:alpha/ui/screens/job_selection/job_tile.dart';
import 'package:alpha/ui/common/alpha_app_bar.dart';
import 'package:flutter/material.dart';

class JobProspectScreen extends StatelessWidget {
  final Job job;
  const JobProspectScreen({super.key, required this.job});

  List<Widget> buildJobTiles() {
    List<Widget> jobTiles = [];
    Job curJob = job;

    while (curJob.nextJob != null) {
      jobTiles.add(JobTile(job: curJob.nextJob!, eligible: true));
      curJob = curJob.nextJob!;
    }

    return jobTiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AlphaAppBar(title: "Job Prospects"),
      body: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const SizedBox(width: 30.0),
          Hero(tag: job.jobTitle, child: JobTile(job: job, eligible: true)),
          ...buildJobTiles(),
          const SizedBox(width: 30.0)
        ]),
      ),
    );
  }
}
