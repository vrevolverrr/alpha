import 'package:alpha/logic/economy_logic.dart';
import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/logic/game_logic.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:get_it/get_it.dart';

/// This file contains all the service locators for the commonly used systems in the game.
/// The only singleton used throughout the game is the [GameManager], where
/// it instantiates all relavant managers
///
/// Referencing any manager must be done through the only instance of [GameManager],
/// and should not be instantiated by its own.

/// Service locator for the global singleton of [GameManager]
GameManager get gameManager => GetIt.I.get<GameManager>();

/// Service locator for the [PlayerManager], held by the [GameManager]
PlayerManager get playerManager => GetIt.I.get<GameManager>().playerManager;

/// Service locator for the [activePlayer] instance, held by the [PlayerManager]
Player get activePlayer =>
    GetIt.I.get<GameManager>().playerManager.getActivePlayer();

/// Service locator for the [FinancialMarketManager], held by the [GameManager]
FinancialMarketManager get marketManager =>
    GetIt.I.get<GameManager>().marketManager;

/// Service locator for the [EconomyManager], held by the [GameManager]
EconomyManager get economyManager => GetIt.I.get<GameManager>().economyManager;
