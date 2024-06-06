import 'package:alpha/logic/game_state.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

extension GetGameState on BuildContext {
  GameState get gameState => read<GameState>();
}

extension GetScreenDimensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

extension ShowDismissAlphaDialog on BuildContext {
  void showAlphaDialog(AlphaDialogBuilder builder) =>
      AlphaScaffold.of(this).showAlphaDialog(builder);
  void dismissAlphaDialog() => AlphaScaffold.of(this).dismissAlphaDialog();
}

extension NavigatePage on BuildContext {
  void navigateTo(Widget screen) => Navigator.of(this).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (BuildContext context) => screen),
      (route) => false);
}
