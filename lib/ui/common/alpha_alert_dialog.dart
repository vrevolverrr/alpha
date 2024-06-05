import 'package:alpha/ui/common/alpha_button.dart';
import 'package:flutter/material.dart';

class AlertButtonData {
  final String title;
  final double width;
  final double height;
  final void Function()? onTap;

  const AlertButtonData(
      {required this.title,
      this.width = 280.0,
      this.height = 60.0,
      this.onTap});
}

class AlphaAlertDialog extends StatefulWidget {
  final String title;
  final Widget child;
  final AlertButtonData? next;
  final AlertButtonData? cancel;
  final bool show;

  const AlphaAlertDialog(
      {super.key,
      required this.title,
      required this.child,
      this.next,
      this.cancel,
      this.show = false});

  @override
  State<AlphaAlertDialog> createState() => _AlphaAlertDialogState();
}

class _AlphaAlertDialogState extends State<AlphaAlertDialog> {
  Widget _buildContents() {
    return Column(
      children: <Widget>[
        Text(
          widget.title.toUpperCase(),
          style: const TextStyle(
              fontFamily: "LexendMega",
              fontWeight: FontWeight.w700,
              fontSize: 34.0),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 3.0,
          width: 300.0,
          decoration: BoxDecoration(
              color: Colors.black45, borderRadius: BorderRadius.circular(10.0)),
        ),
        const SizedBox(height: 20.0),
        widget.child,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.cancel != null
                ? AlphaButton(
                    width: widget.cancel!.width,
                    height: widget.cancel!.height,
                    title: widget.cancel!.title,
                    onTap: widget.cancel!.onTap,
                  )
                : const SizedBox(),
            (widget.next != null && widget.cancel != null)
                ? const SizedBox(width: 20.0)
                : const SizedBox(),
            widget.next != null
                ? AlphaButton(
                    width: widget.next!.width,
                    height: widget.next!.height,
                    title: widget.next!.title,
                    color: const Color.fromARGB(255, 164, 211, 151),
                    onTap: widget.next!.onTap,
                  )
                : const SizedBox()
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Durations.medium4,
      curve: Curves.decelerate,
      width: widget.show ? 650.0 : 0.0,
      height: widget.show ? 380.0 : 0.0,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: const Color(0xffFCF7E8),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: const Color(0xff000000), width: 4.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Color(0xff000000), offset: Offset(1.0, 5.0))
          ]),
      child: widget.show
          ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxHeight < 380.0 &&
                    constraints.maxWidth < 590.0) {
                  return const SizedBox();
                }
                return _buildContents();
              },
            )
          : null,
    );
  }
}
