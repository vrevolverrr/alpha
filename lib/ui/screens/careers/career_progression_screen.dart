import 'package:alpha/extensions.dart';
import 'package:alpha/logic/data/careers.dart';
import 'package:alpha/services.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/careers/career_selection_screen.dart';
import 'package:alpha/ui/screens/careers/dialogs/confirm_promote_dialog.dart';
import 'package:alpha/ui/screens/careers/dialogs/confirm_resign_dialog.dart';
import 'package:alpha/ui/screens/careers/widgets/career_progression_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CareerProgressionScreen extends StatefulWidget {
  const CareerProgressionScreen({super.key});

  @override
  State<CareerProgressionScreen> createState() =>
      _CareerProgressionScreenState();
}

class _CareerProgressionScreenState extends State<CareerProgressionScreen> {
  int _selectedIndex = careerManager.getPlayerJob(activePlayer).tier;

  void _handlePageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handlePromote(BuildContext context) {
    Job currentJob = careerManager.getPlayerJob(activePlayer);
    Job nextJob = careerManager.getNextTierJob(currentJob);

    context.showDialog(buildConfirmPromoteDialog(context, nextJob, () {
      careerManager.promote(activePlayer);
      context.dismissDialog();
    }));
  }

  void _handleResign(BuildContext context) {
    Job currentJob = careerManager.getPlayerJob(activePlayer);

    context.showDialog(buildConfirmResignDialog(context, currentJob, () {
      careerManager.resign(activePlayer);
      context.navigateAndPopTo(const JobSelectionScreen());
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Career",
        onTapBack: () => Navigator.pop(context),
        children: <Widget>[
          const SizedBox(height: 45.0),
          CarouselSlider(
              options: CarouselOptions(
                  onPageChanged: (index, _) => _handlePageChanged(index),
                  initialPage: careerManager.getPlayerJob(activePlayer).tier,
                  height: 500.0,
                  viewportFraction: 0.35,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  enlargeFactor: 0.2,
                  enableInfiniteScroll: false),
              items: _buildCareerProgressionCards()),
          const SizedBox(height: 30.0),
          Builder(
            builder: (context) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlphaButton(
                  width: 230.0,
                  title: "Resign",
                  icon: Icons.close,
                  onTap: () => _handleResign(context),
                ),
                const SizedBox(width: 20.0),
                (careerManager.canPromote(activePlayer))
                    ? AlphaButton(
                        width: 300.0,
                        title: "Promote",
                        color: const Color(0xFF77D1EA),
                        icon: Icons.arrow_upward_rounded,
                        onTap: () => _handlePromote(context),
                      )
                    : const SizedBox()
              ],
            ),
          )
        ]);
  }

  List<Widget> _buildCareerProgressionCards() {
    Job playerJob = careerManager.getPlayerJob(activePlayer);

    final List<Job> jobProgression =
        Job.values.where((job) => job.career == playerJob.career).toList();

    return jobProgression
        .map((job) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: CareerProgressionCard(
                job: job,
                disabled: playerJob != job,
              ),
            ))
        .toList();
  }
}
