import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/player_creation/widgets/life_goal_selector.dart';
import 'package:alpha/ui/screens/player_creation/widgets/player_avatar_selector.dart';
import 'package:alpha/ui/screens/player_creation/widgets/player_color_selector.dart';
import 'package:flutter/material.dart';

class PlayerCreationScreen extends StatefulWidget {
  const PlayerCreationScreen({super.key});

  @override
  State<PlayerCreationScreen> createState() => _PlayerCreationScreenState();
}

class _PlayerCreationScreenState extends State<PlayerCreationScreen> {
  String _playerName = "";
  PlayerGoals _selectedGoal = PlayerGoals.family;

  late final PlayerAvatarSelectorController _avatarController;
  PlayerColor _selectedColor = playerManager.getAvailableColors().first;

  void _handlePlayerNameEditingComplete(String name) {
    _playerName = name.trim();
  }

  void _handleColorSelection(PlayerColor color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _handleGoalSelection(PlayerGoals goal) {
    setState(() {
      _selectedGoal = goal;
    });
  }

  void _handleAddPlayer() {
    if (_playerName.isEmpty) {
      return;
    }

    playerManager.createPlayer(_playerName, _avatarController.selectedAvatar,
        _selectedColor, _selectedGoal);

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _avatarController = PlayerAvatarSelectorController(
        avatars: playerManager.getAvailableAvatars());
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Create Player",
        onTapBack: () => Navigator.pop(context),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlayerAvatarSelector(
                controller: _avatarController,
                backgroundColor: _selectedColor.color,
              ),
              const SizedBox(width: 60.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 570.0,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Text(
                              "Player Name",
                              style: TextStyles.bold24,
                            ),
                          ),
                          AlphaContainer(
                              width: 480.0,
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 4.0),
                              child: TextField(
                                style: TextStyles.medium20,
                                onChanged: (name) =>
                                    _handlePlayerNameEditingComplete(name),
                                decoration: const InputDecoration(
                                    hintText: "Enter player name",
                                    hintStyle: TextStyles.medium18,
                                    border: InputBorder.none),
                              )),
                          const SizedBox(height: 25.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Text(
                              "Colour",
                              style: TextStyles.bold24,
                            ),
                          ),
                          Row(
                            children: playerManager
                                .getAvailableColors()
                                .map(
                                    (color) => _buildPlayerColorSelector(color))
                                .toList(),
                          ),
                          const SizedBox(height: 20.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Text(
                              "Starting Career",
                              style: TextStyles.bold24,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                            child: Text(
                              "Life Goal",
                              style: TextStyles.bold24,
                            ),
                          ),
                          SizedBox(
                            height: 220.0,
                            child: Row(
                              children: PlayerGoals.values.map((goal) {
                                return _buildLifeGoalSelector(goal);
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  AlphaButton(
                    width: 600.0,
                    title: "Add Player",
                    onTap: _handleAddPlayer,
                    color: AlphaColors.green,
                  )
                ],
              ),
            ],
          ),
        ]);
  }

  Widget _buildPlayerColorSelector(PlayerColor color) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: GestureDetector(
        onTap: () => _handleColorSelection(color),
        child: PlayerColorSelector(
          color: color.color,
          selected: _selectedColor == color,
        ),
      ),
    );
  }

  Widget _buildLifeGoalSelector(PlayerGoals goal) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: GestureDetector(
        onTap: () => _handleGoalSelection(goal),
        child: LifeGoalSelector(
          goal: goal,
          selected: _selectedGoal == goal,
        ),
      ),
    );
  }
}
