import 'package:flutter/material.dart';

class AlphaSnackbar extends StatefulWidget {
  const AlphaSnackbar({super.key});

  @override
  State<AlphaSnackbar> createState() => _AlphaSnackbarState();
}

class _AlphaSnackbarState extends State<AlphaSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0.0, -20.0),
      child: Container(
        width: 580.0,
        height: 55.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
