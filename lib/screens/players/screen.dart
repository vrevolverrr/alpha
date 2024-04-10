import 'package:alpha/model/player.dart';
import 'package:alpha/screens/players/player_card.dart';
import 'package:flutter/material.dart';

class PlayersScreen extends StatefulWidget {
  final List<Player> players;

  const PlayersScreen({super.key, required this.players});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 150.0,
            ),
            PlayerCard(player: widget.players[0]),
            PlayerCard(
              player: widget.players[1],
            ),
            const SizedBox(
              width: 150.0,
            )
          ],
        ),
        const SizedBox(height: 50.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 5.0,
            ),
            PlayerCard(
              player: widget.players[2],
            ),
            PlayerCard(player: widget.players[3]),
            PlayerCard(player: widget.players[4]),
            const SizedBox(
              width: 5.0,
            )
          ],
        )
      ],
    );
  }
}
