import 'package:alpha/model/game_state.dart';
import 'package:alpha/model/game_tiles.dart';
import 'package:alpha/model/player.dart';
import 'package:alpha/screens/job_selection/screen.dart';
import 'package:alpha/widgets/bottom_floating_bar.dart';
import 'package:alpha/widgets/alpha_app_bar.dart';
import 'package:alpha/widgets/selection_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameTileSelectionScreen extends StatefulWidget {
  const GameTileSelectionScreen({super.key});

  @override
  State<GameTileSelectionScreen> createState() =>
      _GameTileSelectionScreenState();
}

class _GameTileSelectionScreenState extends State<GameTileSelectionScreen> {
  GameTile? selectedTile;

  final Map<GameTile, void Function(BuildContext context)> tileActions = {
    /// Maps each game tile to the corresponding [PageRoute]

    GameTile.workTile: (context) => Navigator.of(context).push(
        CupertinoPageRoute(builder: (context) => const JobSelectionScreen()))
  };

// TODO refactor this shit
  Column buildTilesGrid(Player player) {
    List<Widget> row = [];
    List<Widget> column = [];

    void updateSelectedTileCallback(GameTile tile) =>
        setState(() => selectedTile = tile);

    for (GameTile tile in GameTile.values) {
      row.add(GestureDetector(
        onTap: () => updateSelectedTileCallback(tile),
        child: SelectionTile(
          image: Image.asset("assets/img/dashboard_budgeting.png"),
          eligible: true,
          selected:
              selectedTile != null && selectedTile!.tileName == tile.tileName,
          children: [
            Text(
              tile.tileName,
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Text(tile.tileDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      height: 1.6)),
            ),
          ],
        ),
      ));

      if (row.length >= 3) {
        column.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 30.0),
              ...row,
              const SizedBox(width: 30.0)
            ]));
        column.add(const SizedBox(height: 30.0));
        row = [];
      }
    }

    column.add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const SizedBox(width: 30.0),
      ...row,
      const SizedBox(width: 30.0)
    ]));

    return Column(
      children: [
        const SizedBox(height: 10.0),
        ...column,
        const SizedBox(height: 140.0)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AlphaAppBar(title: "Select Tile"),
      body: Stack(
        children: [
          Consumer<GameState>(
            builder: (context, gameState, child) => SingleChildScrollView(
                child: buildTilesGrid(gameState.activePlayer)),
          ),
          AnimatedBottomFloatingBar(
              selected: selectedTile != null,
              text: (() {
                if (selectedTile == null) {
                  return const Text(
                      "✋ Please select the tile that you have landed on",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500));
                }

                return RichText(
                    text: TextSpan(
                  text: "You have landed on the ",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                        text: selectedTile!.tileName,
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    const TextSpan(text: " tile on the board")
                  ],
                ));
              })(),
              onProceed: () => tileActions[selectedTile]!(context))
        ],
      ),
    );
  }
}
