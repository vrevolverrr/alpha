import 'package:flutter/material.dart';

/// Creates an animated button in the style of the game.
class AlphaButton extends StatefulWidget {
  final double width, height;
  final String title;
  final Color? color;
  final IconData? icon;

  /// Whether or not the button is disabled.\
  /// The button turns grey when disabled and [onTapDisabled] is called instead
  /// of [onTap] when the button is tapped.
  final bool disabled;

  /// The function called when the button is tapped while `disabled` is false.
  final void Function()? onTap;

  /// The function called when the button is tapped while `disabled` is true.
  final void Function()? onTapDisabled;

  const AlphaButton(
      {super.key,
      required this.width,
      this.height = 70.0,
      required this.title,
      this.color,
      this.icon,
      this.disabled = false,
      this.onTap,
      this.onTapDisabled});

  /// Creates a default [AlphaButton] for the next action.
  static AlphaButton next({void Function()? onTap}) {
    return AlphaButton(
      width: 185.0,
      height: 70.0,
      title: "Next",
      icon: Icons.arrow_back_rounded,
      onTap: onTap,
    );
  }

  @override
  State<AlphaButton> createState() => _AlphaButtonState();
}

class _AlphaButtonState extends State<AlphaButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _hover = true),
      onTapCancel: () => setState(() => _hover = false),
      onTapUp: (_) => setState(() => _hover = false),
      onTap: !widget.disabled ? widget.onTap : widget.onTapDisabled,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 80),
        offset: _hover ? const Offset(0.04, 0.04) : Offset.zero,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          // transform:
          //  _hover ? (Matrix4.identity()..translate(2.0, 2.0, 0.0)) : null,
          padding: const EdgeInsets.fromLTRB(30.0, 5.0, 22.0, 5.0),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 4.0),
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: !_hover
                ? const <BoxShadow>[
                    BoxShadow(color: Colors.black, offset: Offset(4.0, 4.0))
                  ]
                : null,
            color: !widget.disabled
                ? (widget.color ?? const Color(0xffFF6B6B))
                : const Color.fromARGB(255, 188, 188, 188),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title.toUpperCase(),
                style: const TextStyle(
                    fontFamily: "PublicSans",
                    fontWeight: FontWeight.w900,
                    fontSize: 24.0),
              ),
              Transform.rotate(
                angle: (widget.icon == null ||
                        widget.icon == Icons.arrow_back_rounded)
                    ? 3.142
                    : 0.0,
                child: Icon(
                  widget.icon ?? Icons.arrow_back_rounded,
                  size: 32.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
