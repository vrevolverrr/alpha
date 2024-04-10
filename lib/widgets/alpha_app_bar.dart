import 'package:flutter/material.dart';

class AlphaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AlphaAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.arrow_back,
          size: 28.0,
          color: Colors.black87,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
