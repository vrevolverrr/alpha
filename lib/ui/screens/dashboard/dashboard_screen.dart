import 'package:alpha/assets.dart';
import 'package:alpha/extensions.dart';
import 'package:alpha/logic/skills_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/assets/assets_screen.dart';
import 'package:alpha/ui/screens/budgeting/budgeting_screen.dart';
import 'package:alpha/ui/screens/dashboard/widgets/dashboard_action_card.dart';
import 'package:alpha/ui/screens/dashboard/widgets/dashboard_career_card.dart';
import 'package:alpha/ui/screens/dashboard/widgets/dashboard_player_card.dart';
import 'package:alpha/ui/screens/dashboard/widgets/dashboard_player_stats.dart';
import 'package:alpha/ui/screens/investments/investments_screen.dart';
import 'package:alpha/ui/screens/next_turn/next_turn_screen.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _handleEndTurn(BuildContext context) {
    gameManager.nextTurn();
    context.navigateAndPopTo(const PlayersMenuScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Dashboard",
        useDefaultPadding: true,
        landingDialog: (activePlayer.savings.unbudgeted > 0.0)
            ? _buildBudgetingDialog(context, () {
                // context.dismissDialog();
                context.navigateTo(BudgetingScreen());
              })
            : null,
        next: Builder(
          builder: (context) => AlphaButton(
            width: 235.0,
            title: "End Turn",
            onTap: () => _handleEndTurn(context),
          ),
        ),
        children: const <Widget>[
          SizedBox(height: 25.0),
          _DashboardPlayerStats(),
          SizedBox(height: 35.0),
          _DashboardContents(),
        ]);
  }

  AlphaDialogBuilder _buildBudgetingDialog(
          BuildContext context, void Function() onTapConfirm) =>
      AlphaDialogBuilder(
          title: "Budgeting",
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Please allocate budgets for your income",
                  style: TextStyles.bold20,
                ),
              ),
              const SizedBox(height: 15.0),
              const Text("Budget unallocated is"),
              Text(activePlayer.savings.unbudgeted.prettyCurrency,
                  style: const TextStyle(
                      color: Color(0xFF38A83C),
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
          next: DialogButtonData(
              title: "Proceed", width: 380.0, onTap: onTapConfirm));
}

class _DashboardPlayerStats extends StatelessWidget {
  const _DashboardPlayerStats();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ListenableBuilder(
          listenable: activePlayer.savings,
          builder: (context, child) => DashboardPlayerStatCard(
            emoji: "💵",
            title: "Savings",
            value: activePlayer.savings.balance,
            isCurrency: true,
          ),
        ),
        ListenableBuilder(
          listenable: activePlayer.savings,
          builder: (context, child) => DashboardPlayerStatCard(
            emoji: "💵",
            title: "Debt",
            valueColor: const Color(0xFFB52F26),
            value: activePlayer.debt.balance,
            isCurrency: true,
          ),
        ),
        ListenableBuilder(
          listenable: activePlayer.stats,
          builder: (context, child) => DashboardPlayerStatCard(
              emoji: "❤️",
              title: "Happiness",
              value: activePlayer.stats.happiness,
              valueWidth: 50.0),
        ),
        ListenableBuilder(
          listenable: activePlayer.stats,
          builder: (context, child) => DashboardPlayerStatCard(
              emoji: "🕙",
              title: "Time",
              value: activePlayer.stats.time,
              valueWidth: 50.0),
        ),
        ListenableBuilder(
          listenable: activePlayer.stats,
          builder: (context, child) => DashboardPlayerStatCard(
              emoji: "🌏",
              title: "ESG",
              value: activePlayer.stats.time,
              valueWidth: 50.0),
        ),
      ],
    );
  }
}

class _DashboardContents extends StatelessWidget {
  const _DashboardContents();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            DashboardPlayerCard(playerName: activePlayer.name),
            const SizedBox(height: 50.0),
            DashboardCurrentCareerCard(player: activePlayer)
          ],
        ),
        Column(
          children: <Widget>[
            const _DashboardPlayerExpLevel(),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DashboardActionCard(
                  title: "Assets",
                  description: "Manage your assets and liabilities.",
                  image: AlphaAssets.dashboardAssets,
                  onTap: () => context.navigateTo(const AssetsScreen()),
                ),
                const SizedBox(width: 20.0),
                DashboardActionCard(
                  title: "Investments",
                  description: "Invest in various assets to earn money.",
                  image: AlphaAssets.dashboardInvestment,
                  onTap: () => context.navigateTo(const InvestmentsScreen()),
                ),
                const SizedBox(width: 20.0),
                const DashboardActionCard(
                  title: "Businesses",
                  description: "Manage your business operations.",
                  image: AlphaAssets.dashboardBusiness,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class _DashboardPlayerExpLevel extends StatelessWidget {
  const _DashboardPlayerExpLevel();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 750.0,
          height: 55.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: Colors.black, width: 4.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Colors.black, offset: Offset(1.0, 1.0))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 700.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Colors.black, width: 2.0)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ListenableBuilder(
                    listenable: activePlayer.skill,
                    builder: (context, child) => TweenAnimationBuilder<double>(
                        tween: Tween(
                            begin: -900.0,
                            end: activePlayer.skill.levelPercent * 700.0),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.decelerate,
                        builder: (context, value, child) => Container(
                              /// To calculate progress percentage
                              width: value > 0.0 ? value : 0.0,
                              height: 12.0,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFF6B6B),
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                      color: Colors.black, width: 2.0)),
                            )),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            right: 20.0,
            child: Transform.translate(
              offset: const Offset(0.0, -28.0),
              child: ListenableBuilder(
                listenable: activePlayer.skill,
                builder: (context, child) => Text(
                  "XP ${activePlayer.skill.levelExp} / ${SkillLevel.xpPerLevel}",
                  style: TextStyles.bold18,
                ),
              ),
            )),
        Positioned(
            left: 20.0,
            child: Transform.translate(
              offset: const Offset(0.0, -28.0),
              child: ListenableBuilder(
                listenable: activePlayer.skill,
                builder: (context, child) => Text(
                  "LEVEL ${activePlayer.skill.level}",
                  style: TextStyles.bold18,
                ),
              ),
            )),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              transform: Matrix4.translation(Vector3(0, -30.0, 0)),
              padding: const EdgeInsets.only(top: 4.0, right: 2.0),
              width: 150.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: const Color(0xffFFBFCA),
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(color: Colors.black, width: 3.0),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(color: Colors.black, offset: Offset(1.5, 1.5))
                  ]),
              child: const Text(
                "Skill Level",
                style: TextStyles.bold18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
