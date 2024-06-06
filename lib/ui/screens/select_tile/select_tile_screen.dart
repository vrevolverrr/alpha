import 'package:alpha/ui/common/alpha_next_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/select_tile/widget/gametile_card.dart';
import 'package:flutter/material.dart';

class TileSelectionScreen extends StatefulWidget {
  const TileSelectionScreen({super.key});

  @override
  State<TileSelectionScreen> createState() => _TileSelectionScreenState();
}

class _TileSelectionScreenState extends State<TileSelectionScreen> {
  int _selectedIndex = -1;

  Widget _buildGameTileSelectionCard(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() {
        _selectedIndex = index;
      }),
      child: GameTileSelectionCard(
          title: title, selected: _selectedIndex == index),
    );
  }

  void _confirmSelectedTile() {}

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Select Tile",
        next: AlphaNextButton(onTap: _confirmSelectedTile),
        children: <Widget>[
          const SizedBox(height: 30.0),
          const Text(
            "Choose the tile that you have landed on",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 35.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 150.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildGameTileSelectionCard("Education", 0),
                _buildGameTileSelectionCard("Career", 1),
                _buildGameTileSelectionCard("World\nEvent", 2),
              ],
            ),
          ),
          const SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 150.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildGameTileSelectionCard("Oppurtunity", 3),
                _buildGameTileSelectionCard("Business", 4),
                _buildGameTileSelectionCard("Personal\nLife", 5),
              ],
            ),
          )
        ]);
  }
}
