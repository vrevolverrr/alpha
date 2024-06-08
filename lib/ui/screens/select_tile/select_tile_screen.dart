import 'package:alpha/extensions.dart';
import 'package:alpha/ui/common/alpha_next_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/education_selection/education_selection_screen.dart';
import 'package:alpha/ui/screens/job_selection/job_selection_screen.dart';
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

  void _noTileSelected(BuildContext context) {
    context.showSnackbar(message: "✋🏼 Please select a game tile to proceed");
  }

  void _confirmSelectedTile(BuildContext context) {
    late Widget nextScreen;

    switch (_selectedIndex) {
      case 0:
        nextScreen = const EducationSelectionScreen();
        break;
      case 1:
        nextScreen = const JobSelectionScreen();
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      default:
        _noTileSelected(context);
        return;
    }

    context.navigateTo(nextScreen);
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Select Tile",
        next: Builder(
            builder: (BuildContext context) =>
                AlphaNextButton(onTap: () => _confirmSelectedTile(context))),
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
