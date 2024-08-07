import 'package:alpha/assets.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_tag_button.dart';
import 'package:flutter/material.dart';

class PlayerCreationCard extends StatefulWidget {
  final String name;
  final bool isAddCard;
  final void Function()? onTap;

  const PlayerCreationCard(
      {super.key, required this.name, this.isAddCard = false, this.onTap});

  @override
  State<PlayerCreationCard> createState() => _PlayerCreationCardState();
}

class _PlayerCreationCardState extends State<PlayerCreationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: widget.isAddCard
            ? _AddPlayerCardContents(onTap: widget.onTap)
            : _PlayerCreationCardContents(name: widget.name));
  }
}

class _AddPlayerCardContents extends StatelessWidget {
  final void Function()? onTap;
  const _AddPlayerCardContents({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: AlphaAnimatedContainer(
          width: 400.0,
          height: 520.0,
          child: Center(
              child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                    color: const Color.fromARGB(255, 182, 182, 182),
                    width: 3.0)),
            child: const Icon(
              Icons.add,
              size: 40.0,
              color: Color.fromARGB(255, 182, 182, 182),
            ),
          )),
        ));
  }
}

class _PlayerCreationCardContents extends StatelessWidget {
  final String name;
  const _PlayerCreationCardContents({required this.name});

  @override
  Widget build(BuildContext context) {
    return AlphaAnimatedContainer(
      width: 400.0,
      height: 520.0,
      child: Column(
        children: <Widget>[
          Container(
            width: 400.0,
            height: 280.0,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
                color: Color(0xffFF999A)),
            child: Image.asset(AlphaAssets.playerDefault.path),
          ),
          const SizedBox(height: 20.0),
          Text(
            name,
            style: TextStyles.bold30,
          ),
          const SizedBox(height: 15.0),
          const AlphaTagButton(
            width: 220.0,
            height: 45.0,
            color: Color(0xffB5D2AD),
            title: "🔨 Modify Player",
          ),
          const SizedBox(height: 15.0),
          const AlphaTagButton(
            width: 220.0,
            height: 45.0,
            color: Color(0xffEC8484),
            title: "🗑️ Remove Player",
          ),
        ],
      ),
    );
  }
}
