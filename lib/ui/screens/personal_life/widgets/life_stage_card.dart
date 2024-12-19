import 'package:alpha/assets.dart';
import 'package:alpha/extensions.dart';
import 'package:alpha/logic/data/personal_life.dart';
import 'package:alpha/services.dart';
import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class CurrentLifeStageCard extends StatelessWidget {
  final PersonalLifeStatus status;
  final double width;
  final double height;
  final bool focused;
  const CurrentLifeStageCard({
    super.key,
    required this.status,
    required this.width,
    required this.height,
    required this.focused,
  });

  @override
  Widget build(BuildContext context) {
    return AlphaContainer(
      color: const Color.fromARGB(255, 228, 246, 238),
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AlphaAssets.jobProgrammer.path,
                  height: height * 0.6,
                ),
                if (focused)
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 15),
                        child: Text(
                          status.statusDescription,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Sansation",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            Positioned(
              left: width / 2 - width * 0.4 - 10,
              top: height - 260,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 167, 219, 217),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2.0),
                          blurStyle: BlurStyle.normal,
                          blurRadius: 2)
                    ]),
                width: width * 0.8,
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "CURRENT STAGE:",
                          style: TextStyle(
                              fontSize: 9,
                              fontFamily: "LexendMega",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          status.title.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "LexendMega",
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LifeStageCard extends StatelessWidget {
  final PersonalLifeStatus status;
  final double width;
  final double height;
  final bool toPursue;
  const LifeStageCard(
      {super.key,
      required this.status,
      required this.width,
      required this.height,
      required this.toPursue});

  Widget _tagBuilder(
      {required String prefix,
      int? value,
      double? decValue,
      required String suffix}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                prefix,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                  "${(value ?? decValue ?? 0) > 0 ? '+' : ''}${value == null ? decValue!.prettyCurrency : value.toString()}",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(
                width: 3,
              ),
              Text(suffix,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600))
            ],
          ),
        ),
      ),
    );
  }

  void _handlePursueConfirm(BuildContext context) {
    if (playerManager.getActivePlayer().stats.time <
        status.pursueTimeConsumed) {
      context.showSnackbar(
          message: "✋🏼 Insufficient time to ${status.pursuedAction}");
      return;
    }
    AlphaDialogBuilder dialog = _buildPursueDialog(context, () {
      playerManager.getActivePlayer().nextLifeStage();
      context.navigateTo(const DashboardScreen());
    });

    context.showDialog(dialog);
  }

  void _handleRevertConfirm(BuildContext context) {
    if (playerManager.getActivePlayer().stats.happiness <
        status.revertHappinessCost) {
      context.showSnackbar(
          message: "✋🏼 Insufficient happiness to ${status.revertAction}");
      return;
    }
    AlphaDialogBuilder dialog = _buildRevertDialog(context, () {
      playerManager.getActivePlayer().revertLifeStage();
      context.navigateTo(const DashboardScreen());
    });

    context.showDialog(dialog);
  }

  AlphaDialogBuilder _buildPursueDialog(
          BuildContext context, void Function() onTapConfirm) =>
      AlphaDialogBuilder(
          title: status.pursuedAction,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "WILL COST YOU:",
                          style: TextStyle(
                              fontFamily: "LexendMega",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "💵",
                              style: TextStyle(
                                fontSize: 35.0,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                                (status.pursueCostRatio *
                                        playerManager
                                            .getActivePlayer()
                                            .savings
                                            .balance)
                                    .prettyCurrency,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.0,
                                    color: Colors.black)),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "🕙",
                              style: TextStyle(
                                fontSize: 35.0,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text((status.pursueTimeConsumed).toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.0,
                                    color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 50.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 40.0),
                  Container(
                    width: 350,
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "YOU WILL GAIN:",
                              style: TextStyle(
                                  fontFamily: "LexendMega",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "❤️",
                                style: TextStyle(
                                  fontSize: 35.0,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                  "${status.pursueHappinessPR.toString()} per round",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30.0,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
            ],
          ),
          cancel: DialogButtonData(
              title: "cancel",
              onTap: context.dismissDialog,
              width: 400,
              height: 80),
          next: DialogButtonData(
              title: "confirm", onTap: onTapConfirm, width: 400, height: 80));

  AlphaDialogBuilder _buildRevertDialog(
          BuildContext context, void Function() onTapConfirm) =>
      AlphaDialogBuilder(
          title: status.revertAction,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "WILL COST YOU:",
                          style: TextStyle(
                              fontFamily: "LexendMega",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "💵",
                              style: TextStyle(
                                fontSize: 35.0,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                                (status.revertCostRatio *
                                        playerManager
                                            .getActivePlayer()
                                            .savings
                                            .balance)
                                    .prettyCurrency,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.0,
                                    color: Colors.black)),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "❤️",
                              style: TextStyle(
                                fontSize: 35.0,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text((status.revertHappinessCost).toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.0,
                                    color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 50.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 40.0),
                  Container(
                    width: 350,
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "YOU WILL GAIN:",
                              style: TextStyle(
                                  fontFamily: "LexendMega",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "🕙",
                                style: TextStyle(
                                  fontSize: 35.0,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(status.revertTimeGain.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30.0,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
            ],
          ),
          cancel: DialogButtonData(
              title: "cancel",
              onTap: context.dismissDialog,
              width: 400,
              height: 80),
          next: DialogButtonData(
              title: "confirm", onTap: onTapConfirm, width: 400, height: 80));

  @override
  Widget build(BuildContext context) {
    return AlphaContainer(
      width: width,
      height: height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              AlphaAssets.jobProgrammer.path,
              height: height * 0.6,
            ),
          ),
          Container(
            width: width,
            height: height,
            color: toPursue
                ? const Color.fromARGB(100, 49, 234, 95)
                : const Color.fromARGB(100, 150, 0, 0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 180,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Text(
                      toPursue
                          ? status.statusDescription
                          : status.revertDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: "Sansation",
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _tagBuilder(
                            prefix: "❤️",
                            value: toPursue
                                ? status.pursueHappinessPR
                                : -status.revertHappinessCost,
                            suffix: toPursue ? 'per round' : ''),
                        _tagBuilder(
                            prefix: "🕙",
                            value: toPursue
                                ? -status.pursueTimeConsumed
                                : status.revertTimeGain,
                            suffix: ""),
                        _tagBuilder(
                            prefix: "💵",
                            decValue: toPursue
                                ? -status.pursueCostRatio *
                                    playerManager
                                        .getActivePlayer()
                                        .savings
                                        .balance
                                : -status.revertCostRatio *
                                    playerManager
                                        .getActivePlayer()
                                        .savings
                                        .balance,
                            suffix: ""),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: width / 2 - width * 0.35,
            child: AlphaButton(
              color: toPursue
                  ? const Color.fromARGB(255, 49, 234, 95)
                  : const Color(0xffFF6B6B),
              width: width * 0.7,
              height: 80,
              title: toPursue ? status.pursuedAction : status.revertAction,
              fontSize: 20,
              disableIcon: true,
              onTap: () {
                if (toPursue) {
                  _handlePursueConfirm(context);
                } else {
                  _handleRevertConfirm(context);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
