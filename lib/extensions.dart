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

extension ShowdismissDialog on BuildContext {
  void showDialog(AlphaDialogBuilder builder) =>
      AlphaScaffold.of(this).showDialog(builder);
  void dismissDialog() => AlphaScaffold.of(this).dismissDialog();
}

extension ShowDismissAlphaSnackbar on BuildContext {
  void showAlphaSnackbar(
          {required String message,
          Duration duration = const Duration(seconds: 1)}) =>
      AlphaScaffold.of(this).showSnackbar(message: message, duration: duration);
}

extension Navigation on BuildContext {
  void navigateAndPopTo(Widget screen) => Navigator.of(this).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (BuildContext context) => screen),
      (route) => false);

  void navigateTo(Widget screen) => Navigator.of(this).push(
        CupertinoPageRoute(builder: (BuildContext context) => screen),
      );
}
