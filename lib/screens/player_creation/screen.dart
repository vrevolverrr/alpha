import 'package:alpha/screens/job_selection/bottom_floating_bar.dart';
import 'package:alpha/screens/player_creation/player_creation_card.dart';
import 'package:alpha/widgets/alpha_app_bar.dart';
import 'package:flutter/material.dart';

class PlayerCreationScreen extends StatefulWidget {
  const PlayerCreationScreen({super.key});

  @override
  State<PlayerCreationScreen> createState() => _PlayerCreationScreenState();
}

class _PlayerCreationScreenState extends State<PlayerCreationScreen> {
  final PageController pageController = PageController();

  _PlayerCreationScreenState();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AlphaAppBar(title: "Create Player", hasBack: false),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 100.0),
                  GestureDetector(
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 40.0,
                        color: Colors.black54,
                      ),
                      onTap: () => {}),
                  SizedBox(
                      width: 500.0,
                      height: 610.0,
                      child:
                          PageView(controller: pageController, children: const [
                        PlayerCreationCard(),
                        PlayerCreationCard(),
                        PlayerCreationCard(),
                        PlayerCreationCard(),
                        PlayerCreationCard(),
                      ])),
                  GestureDetector(
                      child: Transform.rotate(
                          angle: 3.14,
                          child: const Icon(Icons.arrow_back_ios_rounded,
                              size: 40.0, color: Colors.black54)),
                      onTap: () => {}),
                  const SizedBox(
                    width: 100.0,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ));
  }
}
