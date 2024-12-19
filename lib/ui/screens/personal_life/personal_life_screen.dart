import 'package:alpha/extensions.dart';
import 'package:alpha/logic/data/personal_life.dart';
import 'package:alpha/services.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:alpha/ui/screens/dashboard/widgets/dashboard_player_stats.dart';
import 'package:alpha/ui/screens/personal_life/widgets/life_stage_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PersonalLifeScreen extends StatefulWidget {
  const PersonalLifeScreen({super.key});

  @override
  State<PersonalLifeScreen> createState() => _PersonalLifeScreenState();
}

class _PersonalLifeScreenState extends State<PersonalLifeScreen> {
  late final List<PersonalLifeStatus> carouselItems;
  late final PersonalLifeStatus currentStatus;
  bool onCurrentStatus = true;

  @override
  void initState() {
    super.initState();
    carouselItems = playerManager.getActivePlayer().personalLife.getList();
    currentStatus = playerManager.getActivePlayer().personalLife.status;
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Personal Life",
        onTapBack: () => Navigator.pop(context),
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListenableBuilder(
                    listenable: activePlayer.savings,
                    builder: (context, child) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: DashboardPlayerStatCard(
                        emoji: "💵",
                        title: "Savings",
                        value: activePlayer.savings.balance,
                        isCurrency: true,
                      ),
                    ),
                  ),
                  ListenableBuilder(
                    listenable: activePlayer.stats,
                    builder: (context, child) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: DashboardPlayerStatCard(
                          emoji: "❤️",
                          title: "Happiness",
                          value: activePlayer.stats.happiness,
                          valueWidth: 50.0),
                    ),
                  ),
                  ListenableBuilder(
                    listenable: activePlayer.stats,
                    builder: (context, child) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: DashboardPlayerStatCard(
                          emoji: "🕙",
                          title: "Time",
                          value: activePlayer.stats.time,
                          valueWidth: 50.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: CarouselSlider.builder(
                itemCount: carouselItems.length,
                itemBuilder: (context, index, _) {
                  final temp = carouselItems[index];

                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: currentStatus == carouselItems[index]
                        ? CurrentLifeStageCard(
                            focused: onCurrentStatus,
                            status: temp,
                            width: 350,
                            height: 500,
                          )
                        : LifeStageCard(
                            status: temp,
                            width: 350,
                            height: 500,
                            toPursue:
                                index > carouselItems.indexOf(currentStatus),
                          ),
                  );
                },
                options: CarouselOptions(
                  onPageChanged: (index, _) {
                    setState(() {
                      if (currentStatus == carouselItems[index]) {
                        onCurrentStatus = true;
                      } else {
                        onCurrentStatus = false;
                      }
                    });
                  },
                  initialPage: carouselItems.indexOf(currentStatus),
                  height: 500,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  viewportFraction: 0.35,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  enableInfiniteScroll: false,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          if (onCurrentStatus)
            AlphaButton(
              color: const Color.fromARGB(255, 106, 202, 196),
              width: 300,
              title: "Remain ${currentStatus.title}",
              onTap: () => context.navigateTo(const DashboardScreen()),
            ),
        ]);
  }
}
