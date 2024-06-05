import 'package:alpha/extensions.dart';
import 'package:alpha/logic/game_state.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/player_creation_menu/widgets/player_creation_card.dart';
import 'package:alpha/ui/screens/players_menu/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PlayerCreationMenuScreen extends StatefulWidget {
  final void Function()? onTapBack;

  const PlayerCreationMenuScreen({super.key, this.onTapBack});

  @override
  State<PlayerCreationMenuScreen> createState() => _PlayerCreationMenuScreen();
}

class _PlayerCreationMenuScreen extends State<PlayerCreationMenuScreen> {
  final PageController _pageController =
      PageController(viewportFraction: 0.4, initialPage: 0);

  void _updateScroll() {
    // debugPrint(_pageController.offset.toString());
  }

  @override
  void initState() {
    _pageController.addListener(_updateScroll);
    super.initState();
  }

  List<Widget> _buildChildrenCards() {
    final List<Widget> cards = [];
    final players = context.gameState.players;

    for (final player in players) {
      cards.add(PlayerCreationCard(
        name: player.name,
      ));
    }

    if (players.length < 5) {
      cards.add(PlayerCreationCard(
        name: "_",
        isAddCard: true,
        onTap: _addPlayer,
      ));
    }

    return cards;
  }

  void _addPlayer() {
    setState(() {
      context.gameState.createPlayer("Bryan");
      Future.delayed(const Duration(milliseconds: 80), () {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 420),
            curve: Curves.decelerate);
      });
    });
  }

  void _startGame(BuildContext context) {
    if (context.gameState.numPlayers < 5) {
      AlphaScaffold.of(context).showSnackbar(
          message: "✋🏼 There are not enough players to start the game.");
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const PlayersMenuScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Players",
      onTapBack: widget.onTapBack,
      mainAxisAlignment: MainAxisAlignment.center,
      next: Builder(
          builder: (BuildContext context) => AlphaButton(
                width: 200.0,
                height: 70.0,
                title: "START",
                disabled: context.gameState.numPlayers > 5,
                onTap: () => _startGame(context),
              )),
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 500.0,
          child: PageView(
            controller: _pageController,
            physics: const ClampingScrollPhysics(),
            children: _buildChildrenCards(),
          ),
        ),
        const SizedBox(height: 50.0)
      ],
    );
  }
}
