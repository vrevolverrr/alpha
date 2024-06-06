import 'package:alpha/logic/game_state.dart';
import 'package:alpha/ui/screens/dice_roll/dice_roll_screen.dart';
import 'package:alpha/ui/screens/players_menu/player_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayersMenuScreen extends StatefulWidget {
  const PlayersMenuScreen({super.key});

  @override
  State<PlayersMenuScreen> createState() => _PlayersMenuScreenState();
}

class _PlayersMenuScreenState extends State<PlayersMenuScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));

    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void onTapPlayerCard() {
    /// Callback for tapping the active [PlayerCard]
    /// Rolls the dice and pushes to the [DiceRollScreen]

    // Read the current [GameState] from global provider

    Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
      return const DiceRollScreen();
    }));
  }

  Widget playerCardBuilder(int index) {
    GameState gameState = context.read<GameState>();

    if (gameState.activePlayerIndex != index) {
      return PlayerCard(
        player: gameState.players[index],
        onTap: null,
      );
    }

    final scaleAnimation = Tween(begin: 1.0, end: 1.08)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(animationController);

    // current active [PlayerCard]
    return AnimatedBuilder(
        animation: scaleAnimation,
        builder: (context, child) =>
            Transform.scale(scale: scaleAnimation.value, child: child!),
        child: PlayerCard(
          player: gameState.players[index],
          onTap: gameState.activePlayerIndex == index ? onTapPlayerCard : null,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GameState>(
        builder: (context, gameState, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 150.0),
                playerCardBuilder(0),
                playerCardBuilder(1),
                const SizedBox(width: 150.0)
              ],
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 5.0),
                playerCardBuilder(2),
                playerCardBuilder(3),
                playerCardBuilder(4),
                const SizedBox(width: 5.0)
              ],
            )
          ],
        ),
      ),
    );
  }
}
