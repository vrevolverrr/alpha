import 'package:alpha/logic/events_manager.dart';
import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/logic/game_logic.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:get_it/get_it.dart';

GameManager get gameManager => GetIt.I.get<GameManager>();
PlayerManager get playerManager => GetIt.I.get<GameManager>().playerManager;
Player get activePlayer =>
    GetIt.I.get<GameManager>().playerManager.getActivePlayer();
FinancialMarketManager get marketManager =>
    GetIt.I.get<GameManager>().marketManager;
AlphaEventsManager get eventsManager =>
    GetIt.I.get<GameManager>().eventsManager;
