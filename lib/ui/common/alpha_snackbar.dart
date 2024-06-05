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
    return const SizedBox();
  }
}
