import 'package:flutter/material.dart';

class AlphaSnackbar extends StatefulWidget {
  final String message;
  final AnimationController controller;
  const AlphaSnackbar(
      {super.key, required this.message, required this.controller});

  @override
  State<AlphaSnackbar> createState() => _AlphaSnackbarState();
}

class _AlphaSnackbarState extends State<AlphaSnackbar>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _snackAnimation;

  void _initAnimation() {
    widget.controller.duration = const Duration(milliseconds: 1200);
    _snackAnimation = Tween<double>(begin: 65.0, end: -40.0)
        .chain(CurveTween(curve: Curves.elasticOut))
        .animate(widget.controller);
  }

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _snackAnimation,
        builder: (BuildContext context, Widget? child) => Transform.translate(
              offset: Offset(0.0, _snackAnimation.value),
              child: Container(
                width: 580.0,
                height: 60.0,
                padding: const EdgeInsets.fromLTRB(20.0, .0, 20.0, .0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 4.0),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(1.0, 3.0),
                      )
                    ]),
                child: Text(
                  widget.message,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18.0),
                ),
              ),
            ));
  }
}
