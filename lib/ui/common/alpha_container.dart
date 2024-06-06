import 'package:flutter/material.dart';

class AlphaContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Offset? shadowOffset;
  final Widget child;

  const AlphaContainer(
      {super.key,
      this.width,
      this.height,
      this.padding,
      this.shadowOffset,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black, width: 4.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black,
                offset: shadowOffset ?? const Offset(0.5, 3.0))
          ]),
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
      super.width,
      super.height,
      super.shadowOffset = const Offset(0.5, 3.0),
      super.padding,
      required super.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: duration,
        curve: curve,
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black, width: 4.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black,
                  offset: shadowOffset ?? const Offset(0.5, 3.0))
            ]),
        child: child);
  }
}
