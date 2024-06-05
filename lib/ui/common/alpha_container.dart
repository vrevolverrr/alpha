import 'package:flutter/material.dart';

final BoxDecoration _boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20.0),
    border: Border.all(color: Colors.black, width: 4.0),
    boxShadow: const <BoxShadow>[
      BoxShadow(color: Colors.black, offset: Offset(0.5, 3.0))
    ]);

class AlphaContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const AlphaContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: _boxDecoration,
      child: child,
    );
  }
}

class AlphaAnimatedContainer extends AlphaContainer {
  final Duration duration;
  final Curve curve;

  const AlphaAnimatedContainer(
      {super.key,
      this.duration = const Duration(milliseconds: 120),
      this.curve = Curves.linear,
      required super.width,
      required super.height,
      required super.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: duration,
        curve: curve,
        width: width,
        height: height,
        decoration: _boxDecoration,
        child: child);
  }
}
