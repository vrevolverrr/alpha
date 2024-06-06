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
  @override
  Widget build(BuildContext context) {
    return const AlphaScaffold(
        title: "Select Tile",
        next: AlphaNextButton(),
        children: <Widget>[
          SizedBox(height: 30.0),
          Text(
            "Choose the tile that you have landed on",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 150.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GameTileSelectionCard(),
                GameTileSelectionCard(),
                GameTileSelectionCard(),
              ],
            ),
          ),
          SizedBox(height: 30.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 150.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GameTileSelectionCard(),
                GameTileSelectionCard(),
                GameTileSelectionCard(),
              ],
            ),
          )
        ]);
  }
}
