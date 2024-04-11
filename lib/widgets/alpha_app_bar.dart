import 'package:flutter/material.dart';

class AlphaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final void Function()? onTap;

  const AlphaAppBar({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (onTap != null) onTap!();
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.arrow_back,
          size: 28.0,
          color: Colors.black87,
        ),
      ),
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
