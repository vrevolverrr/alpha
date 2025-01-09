import 'dart:async';
import 'dart:math';

import 'package:alpha/extensions.dart';
import 'package:alpha/logic/data/opportunity.dart';
import 'package:alpha/logic/hints_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:alpha/ui/screens/opportunity/dialogs/landing_dialog.dart';
import 'package:alpha/ui/screens/opportunity/widgets/opportunity_card.dart';
import 'package:flutter/material.dart';

class OpportunityScreen extends StatefulWidget {
  const OpportunityScreen({super.key});

  @override
  State<OpportunityScreen> createState() => _OpportunityScreenState();
}

class _OpportunityScreenState extends State<OpportunityScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller; // Controller for animation
  late AnimationController _spinningEffectController;
  late AnimationController _levitationController;
  late AnimationController _flipController;
  late AnimationController _dropController;
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
  late Animation<double> _flipAnimation;
  late Animation<double> _dropAnimation;

  double leftTarget = 250; // Target left position
  double rotationTarget = 0; // Target rotation value
  double top2 = 80;
  double top3 = 80;

  bool _animationTriggered = false;
  bool _showDrawedCard = false;
  bool _displayPrize = false;

  late final Opportunity opportunityChosen = gameManager.getOpportunityPrize();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _spinningEffectController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _levitationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _dropController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

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
    _rotateAnimation = Tween(begin: 2 * pi, end: 0.0).animate(CurvedAnimation(
        parent: _spinningEffectController, curve: Curves.linear));
    _levitationAnimation =
        Tween(begin: 75.00, end: -75.0).animate(_levitationController);
    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.easeInOut,
      ),
    );

    _dropAnimation =
        Tween<double>(begin: _levitationAnimation.value, end: 40.0).animate(
      CurvedAnimation(
        parent: _dropController,
        curve: Curves.easeInOut,
      ),
    );

    // Modify the listener to set `_displayPrize` after the flip animation completes
    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() {
          _showDrawedCard = false; // Hide spinning card when flip starts
        });
      }
      if (status == AnimationStatus.completed) {
        _dropController.forward(); // Start the drop animation
        setState(() {
          _displayPrize = true;
        });
      }
    });

    // Set up listener to perform actions when animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showDrawedCard = true;
        });

        Future.delayed(Durations.medium1, () {
          _spinningEffectController.repeat();
          _levitationController.repeat(reverse: true);

          Timer(const Duration(milliseconds: 2500), () {
            _spinningEffectController.stop();
            _levitationController.stop();
            _flipController.forward(); // Start the flip animation
          });
        });
      }
    });
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
        landingDialog:
            (hintsManager.shouldShowHint(activePlayer, Hint.opportunity))
                ? AlphaDialogBuilder.dismissable(
                    title: "Opportunity",
                    dismissText: "Continue",
                    width: 350.0,
                    child: const OpportunityLandingDialog())
                : null,
        next: Builder(
            builder: (BuildContext context) => AlphaButton(
                width: 230.0,
                title: "Confirm",
                onTap: () => _confirmPrize(context))),
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Expanded(
            child: Builder(
                builder: (context) => SizedBox(
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
                          if (!_animationTriggered)
                            Positioned(
                              top: 220,
                              left: 280,
                              child: Builder(
                                  builder: (context) => AlphaButton(
                                        color: const Color(0xFFF99799),
                                        width: 250.0,
                                        height: 80.0,
                                        title: "DRAW CARD", //to add onTap
                                        onTap: _drawCard,
                                      )),
                            ),
                          if (_showDrawedCard && !_flipController.isAnimating)
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
                          if (_flipController.isAnimating || _displayPrize)
                            AnimatedBuilder(
                              animation: Listenable.merge(
                                  [_flipAnimation, _dropAnimation]),
                              builder: (context, child) {
                                double angle = _flipAnimation.value * pi;
                                Widget card;

                                if (angle <= pi / 2) {
                                  card = OpportunityCardBack(
                                      opportunity: opportunityChosen);
                                } else {
                                  card = OpportunityCardFront(
                                      opportunity: opportunityChosen);
                                  angle = pi - angle;
                                }

                                return Positioned(
                                  left: _left4.value,
                                  top: _dropAnimation.value,
                                  child: Transform(
                                    transform: Matrix4.rotationY(angle),
                                    alignment: Alignment.center,
                                    child: card,
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

  void _confirmPrize(BuildContext context) {
    if (!_displayPrize) {
      context.showSnackbar(message: "✨ Please draw a card to continue");
      return;
    }
    context.navigateAndPopTo(const DashboardScreen());
  }
}
