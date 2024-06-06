import 'package:alpha/extensions.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/player_creation_menu/widgets/player_creation_card.dart';
import 'package:alpha/ui/screens/players_menu/screen.dart';
import 'package:flutter/cupertino.dart';

class PlayerCreationMenuScreen extends StatefulWidget {
  final void Function()? onTapBack;

  const PlayerCreationMenuScreen({super.key, this.onTapBack});

  @override
  State<PlayerCreationMenuScreen> createState() => _PlayerCreationMenuScreen();
}

class _PlayerCreationMenuScreen extends State<PlayerCreationMenuScreen> {
  late final PageController _pageController;

  void _updateScroll() {
    // debugPrint(_pageController.offset.toString());
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.4, initialPage: 0);
    _pageController.addListener(_updateScroll);
    super.initState();
  }

  List<Widget> _buildPlayerCards() {
    final List<Widget> cards = [];
    final players = context.gameState.players;

    for (final player in players) {
      cards.add(UnconstrainedBox(
        child: PlayerCreationCard(name: player.name),
      ));
    }

    if (players.length < 5) {
      cards.add(UnconstrainedBox(
          child: PlayerCreationCard(
              name: "_", isAddCard: true, onTap: _addPlayer)));
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

  void _notEnoughPlayers(BuildContext context) {
    AlphaScaffold.of(context).showSnackbar(
        message: "✋🏼 There are not enough players to start the game.");
  }

  void _startGame() {
    context.navigateTo(const PlayersMenuScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Players",
      onTapBack: widget.onTapBack,
      next: Builder(
          builder: (BuildContext context) => AlphaButton(
                width: 200.0,
                height: 70.0,
                title: "START",
                onTap: _startGame,
                disabled: context.gameState.numPlayers < 5,
                onTapDisabled: () => _notEnoughPlayers(context),
              )),
      children: <Widget>[
        const SizedBox(height: 50.0),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 580.0,
          child: PageView(
            controller: _pageController,
            physics: const ClampingScrollPhysics(),
            children: _buildPlayerCards(),
          ),
        ),
        const SizedBox(height: 50.0)
      ],
    );
  }
}
