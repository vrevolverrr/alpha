import 'package:alpha/extensions.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/business/business_selection_screen.dart';
import 'package:alpha/ui/screens/car/car_screen.dart';
import 'package:alpha/ui/screens/careers/career_screen.dart';
import 'package:alpha/ui/screens/education/education_selection_screen.dart';
import 'package:alpha/ui/screens/careers/career_selection_screen.dart';
import 'package:alpha/ui/screens/opportunity/opportunity_screen.dart';
import 'package:alpha/ui/screens/personal_life/personal_life_screen.dart';
import 'package:alpha/ui/screens/real_estate/real_estate_screen.dart';
import 'package:alpha/ui/screens/select_tile/widget/gametile_card.dart';
import 'package:alpha/ui/screens/world_event/world_event_selection.dart';
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

  void _handleNoTileSelected(BuildContext context) {
    context.showSnackbar(message: "✋🏼 Please select a game tile to proceed");
  }

  void _confirmSelectedTile(BuildContext context) {
    late Widget nextScreen;

    switch (_selectedIndex) {
      case 0:
        nextScreen = const EducationSelectionScreen();
        break;
      case 1:
        nextScreen = const CareerScreen();
        break;
      case 2:
        nextScreen = const WheelSpinScreen();
        break;
      case 3:
        nextScreen = const OpportunityScreen();
        break;
      case 4:
        nextScreen = const BusinessSelectionScren();
        break;
      case 5:
        nextScreen = const PersonalLifeScreen();
        break;
      case 6:
        nextScreen = const RealEstateScreen();
        break;
      case 7:
        nextScreen = const CarScreen();
        break;
      default:
        _handleNoTileSelected(context);
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
                AlphaButton.next(onTap: () => _confirmSelectedTile(context))),
        children: <Widget>[
          const SizedBox(height: 30.0),
          const Text(
            "Choose the tile that you have landed on",
            style: TextStyles.medium20,
          ),
          const SizedBox(height: 35.0),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 25.0,
              runSpacing: 40.0,
              children: [
                _buildGameTileSelectionCard("Education", 0),
                _buildGameTileSelectionCard("Career", 1),
                _buildGameTileSelectionCard("World\nEvent", 2),
                _buildGameTileSelectionCard("Oppurtunity", 3),
                _buildGameTileSelectionCard("Business", 4),
                _buildGameTileSelectionCard("Personal\nLife", 5),
                _buildGameTileSelectionCard("Real Estate", 6),
                _buildGameTileSelectionCard("Car", 7),
              ],
            ),
          ),
        ]);
  }
}
