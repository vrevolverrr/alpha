import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:alpha/extensions.dart';
import 'package:alpha/logic/data/opportunity.dart';
import 'package:alpha/logic/game_logic.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:alpha/ui/screens/opportunity/widgets/opportunity_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OpportunityScreen extends StatefulWidget {
  OpportunityScreen({super.key});

  @override
  State<OpportunityScreen> createState() => _OpportunityScreenState();
}

class _OpportunityScreenState extends State<OpportunityScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller; // Controller for animation
  late AnimationController _spinningEffectController;
  late AnimationController _levitationController;
  late Animation<double> _left1;
  late Animation<double> _rotation1;
  late Animation<double> _rotation2;
  late Animation<double> _rotation3;
  late Animation<double> _rotation4;
  late Animation<double> _left2;
  late Animation<double> _top2;
  late Animation<double> _left3;
  late Animation<double> _top3;
  late Animation<double> _left4;
  late Animation<double> _rotateAnimation;
  late Animation<double> _levitationAnimation;

  double leftTarget = 250; // Target left position
  double rotationTarget = 0; // Target rotation value
  double top2 = 80;
  double top3 = 80;

  bool _animationTriggered = false;
  bool _showDrawedCard = false;
  bool _displayPrize = false;

  get opportunityChosen => GameManager().getOpportunityPrize();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _spinningEffectController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _levitationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    // Define animations for position and rotation
    _left1 = Tween<double>(begin: 95, end: leftTarget).animate(_controller);
    _rotation1 =
        Tween<double>(begin: -19, end: rotationTarget).animate(_controller);
    _left2 = Tween<double>(begin: 205, end: leftTarget).animate(_controller);
    _rotation2 =
        Tween<double>(begin: -9, end: rotationTarget).animate(_controller);
    _top2 = Tween<double>(begin: 50, end: top2).animate(_controller);
    _left3 = Tween<double>(begin: 315, end: leftTarget).animate(_controller);
    _rotation3 =
        Tween<double>(begin: 5, end: rotationTarget).animate(_controller);
    _top3 = Tween<double>(begin: 50, end: top3).animate(_controller);
    _left4 = Tween<double>(begin: 425, end: leftTarget).animate(_controller);
    _rotation4 =
        Tween<double>(begin: 17, end: rotationTarget).animate(_controller);
    _rotateAnimation =
        Tween(begin: 2 * pi, end: 0.0).animate(_spinningEffectController);
    _levitationAnimation =
        Tween(begin: 75.00, end: -75.0).animate(CurvedAnimation(
      parent: _levitationController,
      curve: Curves.easeInOut,
    ));

    // Set up listener to perform actions when animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showDrawedCard = true;
        });
        _spinningEffectController.repeat();
        _levitationController.repeat(reverse: true);

        // Start a timer to stop the animations after 5 seconds
        Timer(const Duration(seconds: 3), () {
          _spinningEffectController.stop();
          _levitationController.stop();
          setState(() {
            _displayPrize = true;
          });
        });
      }
    });
  }

  AlphaDialogBuilder _startingDialog() => AlphaDialogBuilder(
      title: "Life presents unexpected opportunities!",
      child: Column(
        children: [
          const SizedBox(
            height: 15.0,
          ),
          const Text(
            "Draw an Opportunity Tile to see what chance or challenge awaits.",
            style: TextStyles.bold30,
          ),
          const Text(
            "It could bring you luck, test your knowledge, or even lighten or tighten your wallet.",
            style: TextStyles.bold30,
          ),
          const SizedBox(
            height: 2.0,
          ),
          const Text(
            "Here’s what you might find:",
            style: TextStyles.bold30,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "• Quiz",
                      style: TextStyles.bold30,
                    ),
                  ),
                  Text(
                    "• CDC Vouchers",
                    style: TextStyles.bold30,
                  ),
                  Text(
                    "• Get Fined",
                    style: TextStyles.bold30,
                  ),
                  Text(
                    "• Win the Lottery",
                    style: TextStyles.bold30,
                  ),
                ]),
          ),
          const SizedBox(height: 50.0),
        ],
      ),
      cancel: DialogButtonData(
        title: "Let's Go!",
        width: 380,
        onTap: () => _closeStartingDialog(context),
      ));

  void _closeStartingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _drawCard() {
    if (!_animationTriggered) {
      setState(() {
        _animationTriggered =
            true; // Mark that the animation has been triggered
      });
      _controller.forward(from: 0.0); // Start the animation
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Opportunity",
        onTapBack: () => Navigator.of(context).pop(),
        // landingMessage: "✨ Draw a card",
        // landingDialog: _startingDialog(),
        next: Builder(
            builder: (BuildContext context) => AlphaButton(
                width: 230.0,
                title: "Confirm",
                icon: Icons.arrow_back_rounded,
                onTap: () => _confirmPrize(context))),
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Expanded(
            child: Builder(
                builder: (context) => Container(
                      width: 900,
                      height: 30,
                      // color: Colors.orange,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              // Get the current values for position and rotation based on animation progress
                              double currentLeft = _left1.value;
                              double currentRotation = _rotation1.value;

                              return Positioned(
                                left:
                                    currentLeft, // Use the current animated position
                                child: RotationTransition(
                                  turns: AlwaysStoppedAnimation(
                                      currentRotation /
                                          360), // Use the current rotation
                                  child: const OpportunityCardBack(
                                    opportunity: Opportunity.lottery,
                                  ),
                                ),
                              );
                            },
                          ),
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              // Get the current values for position and rotation based on animation progress
                              double currentLeft = _left2.value;
                              double currentTop = _top2.value;
                              double currentRotation = _rotation2.value;

                              return Positioned(
                                top: currentTop,
                                left:
                                    currentLeft, // Use the current animated position
                                child: RotationTransition(
                                  turns: AlwaysStoppedAnimation(
                                      currentRotation /
                                          360), // Use the current rotation
                                  child: const OpportunityCardBack(
                                    opportunity: Opportunity.fined,
                                  ),
                                ),
                              );
                            },
                          ),
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              // Get the current values for position and rotation based on animation progress
                              double currentLeft = _left3.value;
                              double currentTop = _top3.value;
                              double currentRotation = _rotation3.value;

                              return Positioned(
                                top: currentTop,
                                left:
                                    currentLeft, // Use the current animated position
                                child: RotationTransition(
                                  turns: AlwaysStoppedAnimation(
                                      currentRotation /
                                          360), // Use the current rotation
                                  child: const OpportunityCardBack(
                                    opportunity: Opportunity.quiz,
                                  ),
                                ),
                              );
                            },
                          ),
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              // Get the current values for position and rotation based on animation progress
                              double currentLeft = _left4.value;
                              double currentRotation = _rotation4.value;

                              return Positioned(
                                left:
                                    currentLeft, // Use the current animated position
                                child: RotationTransition(
                                  turns: AlwaysStoppedAnimation(
                                      currentRotation /
                                          360), // Use the current rotation
                                  child: const OpportunityCardBack(
                                    opportunity: Opportunity.voucher,
                                  ),
                                ),
                              );
                            },
                          ),
                          if (!_showDrawedCard)
                            Positioned(
                              top: 220,
                              left: 280,
                              child: Builder(
                                  builder: (context) => AlphaButton(
                                        color: Color(0xFFF99799),
                                        width: 250,
                                        height: 100,
                                        title: "DRAW CARD", //to add onTap
                                        onTap: _drawCard,
                                      )),
                            ),
                          if (_showDrawedCard)
                            AnimatedBuilder(
                              animation: _spinningEffectController,
                              builder: (context, child) {
                                // Get the current values for position and rotation based on animation progress
                                double currentLeft = _left4.value;
                                double currentRotation = _rotation4.value;
                                double currentTop = _levitationAnimation.value;

                                return Positioned(
                                  top: currentTop,
                                  left:
                                      currentLeft, // Use the current animated position
                                  child: Transform(
                                    transform: Matrix4.rotationY(
                                        _rotateAnimation.value),
                                    alignment: Alignment.center,
                                    child: RotationTransition(
                                      turns: AlwaysStoppedAnimation(
                                          currentRotation /
                                              360), // Use the current rotation
                                      child: OpportunityCardBack(
                                        opportunity: opportunityChosen,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          if (_displayPrize)
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                // Get the current values for position and rotation based on animation progress
                                double currentLeft = _left4.value;
                                double currentRotation = _rotation4.value;

                                return Positioned(
                                  left:
                                      currentLeft, // Use the current animated position
                                  child: RotationTransition(
                                    turns: AlwaysStoppedAnimation(
                                        currentRotation /
                                            360), // Use the current rotation
                                    child: OpportunityCardFront(
                                      opportunity: opportunityChosen,
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    )),
          ),
          const SizedBox(
            height: 70.0,
          ),
        ]);
  }

  _confirmPrize(BuildContext context) {
    if (!_displayPrize) {
      context.showSnackbar(message: "✨ Please draw a card to continue");
      return;
    }
    // TO-DO
    // add the player stats logic
    context.navigateAndPopTo(const DashboardScreen());
  }
}
