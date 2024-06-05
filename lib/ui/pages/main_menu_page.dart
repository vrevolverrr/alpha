import 'package:alpha/ui/screens/landing/landing_screen.dart';
import 'package:alpha/ui/screens/player_creation/player_creation_screen.dart';
import 'package:alpha/ui/screens/player_creation_menu/player_creation_menu_screen.dart';
import 'package:flutter/material.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int _page = 0;
  final PageController _pageController = PageController();

  void _incrementPage() {
    setState(() {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 540),
          curve: Curves.easeOutExpo);
      _page++;
    });
  }

  void _decrementPage() {
    setState(() {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 540),
          curve: Curves.easeOutExpo);
      _page--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        LandingScreen(onTapNext: _incrementPage),
        PlayerCreationMenuScreen(onTapBack: _decrementPage),
        PlayerCreationScreen()
      ],
    );
  }
}
