import 'package:flutter/material.dart';

class RenderIfNotNull<T> extends StatelessWidget {
  final T nullable;
  final Widget child;

  const RenderIfNotNull(
      {super.key, required this.nullable, required this.child});

  @override
  Widget build(BuildContext context) {
    return (nullable != null) ? child : const SizedBox();
  }
}

class RenderIfTrue extends StatelessWidget {
  final bool condition;
  final Widget child;
  const RenderIfTrue({super.key, required this.condition, required this.child});

  @override
  Widget build(BuildContext context) => condition ? child : const SizedBox();
}

class RenderIfFalse extends StatelessWidget {
  final bool condition;
  final Widget child;

  const RenderIfFalse(
      {super.key, required this.condition, required this.child});

  @override
  Widget build(BuildContext context) => !condition ? child : const SizedBox();
}
