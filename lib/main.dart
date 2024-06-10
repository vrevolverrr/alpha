import 'package:alpha/logic/game_state.dart';
import 'package:alpha/ui/pages/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        // Instantiate a [GameState] that will be accessed by all children
        create: (BuildContext context) => GameState(),
        child: MaterialApp(
          title: 'Alpha Game',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffFCF7E8),
            useMaterial3: true,
            fontFamily: "MazzardH",
          ),
          home: const MainMenuPage(),
        ));
  }
}
