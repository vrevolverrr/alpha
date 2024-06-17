import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:flutter/material.dart';

class PlayerCard extends StatefulWidget {
  final Player player;
  final void Function()? onTap;

  const PlayerCard({super.key, required this.player, this.onTap});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: (activePlayer.name != widget.player.name)
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.grey,
              backgroundBlendMode: BlendMode.saturation)
          : null,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        scale: !hover ? 1.0 : 1.02,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.onTap,
          onTapDown: (TapDownDetails _) => setState(() {
            hover = true;
          }),
          onTapUp: (TapUpDetails _) => setState(() {
            hover = false;
          }),
          onTapCancel: () => setState(() {
            hover = false;
          }),
          child: Container(
            width: 220.0,
            height: 290.0,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(60, 149, 157, 165),
                      offset: Offset(0, 3),
                      blurRadius: 12)
                ],
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 135.0,
                  height: 135.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("assets/images/users_default.png"),
                ),
                const SizedBox(height: 15.0),
                Text(
                  widget.player.name,
                  style: TextStyles.bold20,
                ),
                const SizedBox(height: 6.0),
                Text(
                  "💵 ${widget.player.savings}",
                  style: TextStyles.medium20,
                ),
                const SizedBox(height: 5.0),
                Text(
                  "🩷 ${widget.player.stats.happiness}",
                  style: TextStyles.medium20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
