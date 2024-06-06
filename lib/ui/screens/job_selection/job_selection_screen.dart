import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/job_selection/widget/job_selection_card.dart';
import 'package:flutter/material.dart';

class JobSelectionScreen extends StatefulWidget {
  const JobSelectionScreen({super.key});

  @override
  State<JobSelectionScreen> createState() => _JobSelectionScreenState();
}

class _JobSelectionScreenState extends State<JobSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Choose a Job",
        onTapBack: () => Navigator.of(context).pop(),
        children: <Widget>[
          const SizedBox(height: 30.0),
          Expanded(
            child: GridView.count(
              childAspectRatio: 0.78,
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
              mainAxisSpacing: 50.0,
              crossAxisSpacing: 50.0,
              crossAxisCount: 3,
              children: const [
                JobSelectionCard(),
                JobSelectionCard(),
                JobSelectionCard(),
                JobSelectionCard(),
                JobSelectionCard(),
                JobSelectionCard(),
              ],
            ),
          )
        ]);
  }
}
