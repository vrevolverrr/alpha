import 'package:flutter/material.dart';

class AnimatedBottomFloatingBar extends StatefulWidget {
  final bool selected;
  final Widget text;
  final Widget invalidText;
  final AnimationController animationController;
  final void Function() onProceed;

  const AnimatedBottomFloatingBar(
      {super.key,
      required this.selected,
      required this.text,
      required this.invalidText,
      required this.animationController,
      required this.onProceed});

  @override
  State<AnimatedBottomFloatingBar> createState() =>
      _AnimatedBottomFloatingBar();
}

class _AnimatedBottomFloatingBar extends State<AnimatedBottomFloatingBar>
    with SingleTickerProviderStateMixin {
  late final Animation<double> offsetAnimation;

  @override
  void initState() {
    offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(widget.animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          setState(() {});
        }

        if (status == AnimationStatus.dismissed) {
          // on reverse complete, hold for awhile before updating the state
          Future.delayed(
              const Duration(milliseconds: 600), () => setState(() {}));
        }

        if (status == AnimationStatus.completed) {
          widget.animationController.reverse();
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedBuilder(
            animation: offsetAnimation,
            builder: (context, child) => Transform.translate(
                  offset: Offset(offsetAnimation.value, 0),
                  child: child!,
                ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 80),
              curve: Curves.easeOut,
              width: 650.0,
              height: 70.0,
              margin: const EdgeInsets.only(bottom: 40.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: widget.animationController.isAnimating
                      ? const Color.fromARGB(255, 242, 80, 80)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(150, 149, 157, 165),
                        offset: Offset(0, 12),
                        blurRadius: 20,
                        spreadRadius: 0)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  !widget.animationController.isAnimating
                      ? widget.text
                      : widget.invalidText,
                  (widget.selected && !widget.animationController.isAnimating)
                      ? GestureDetector(
                          onTap: widget.onProceed,
                          behavior: HitTestBehavior.translucent,
                          child: Row(
                            children: [
                              const Text(
                                "Proceed",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 94, 94, 94),
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(width: 5.0),
                              Transform.rotate(
                                angle: 3.14,
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 17.0,
                                  color: Color.fromARGB(255, 94, 94, 94),
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            )));
  }
}
