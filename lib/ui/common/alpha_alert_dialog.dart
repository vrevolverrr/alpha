import 'package:alpha/ui/common/alpha_button.dart';
import 'package:flutter/material.dart';

class DialogButtonData {
  /// Helper class to encapsulate the properties of the
  final String title;
  final double width;
  final double height;
  final void Function()? onTap;

  const DialogButtonData(
      {required this.title,
      this.width = 280.0,
      this.height = 60.0,
      this.onTap});
}

class _AlertDialogContents extends StatelessWidget {
  /// Creates a widget for the contents of the [AlphaAlertDialog].

  /// The top title of the dialog.
  final String title;

  /// The properties of the "next" and cancel buttons of the dialog.
  final DialogButtonData? next;
  final DialogButtonData? cancel;

  /// The child to display below the title.
  final Widget child;

  const _AlertDialogContents(
      {required this.title, this.next, this.cancel, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title.toUpperCase(),
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
        child,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            cancel != null
                ? AlphaButton(
                    width: cancel!.width,
                    height: cancel!.height,
                    title: cancel!.title,
                    onTap: cancel!.onTap,
                  )
                : const SizedBox(),
            (next != null && cancel != null)
                ? const SizedBox(width: 20.0)
                : const SizedBox(),
            next != null
                ? AlphaButton(
                    width: next!.width,
                    height: next!.height,
                    title: next!.title,
                    color: const Color.fromARGB(255, 164, 211, 151),
                    onTap: next!.onTap,
                  )
                : const SizedBox()
          ],
        )
      ],
    );
  }
}

class AlphaAlertDialog extends StatefulWidget {
  /// The main widget that defines the custom alert dialog

  /// The top title of the dialog.
  final String title;

  /// The properties of the "next" and cancel buttons of the dialog.
  final DialogButtonData? next;
  final DialogButtonData? cancel;

  /// The child to display below the title.
  final Widget child;

  /// Whether or not to show the dialog.
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
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Durations.medium4,
      curve: Curves.decelerate,

      /// animates the dialog expanding and closing
      width: widget.show ? 650.0 : 0.0,
      height: widget.show ? 380.0 : 0.0,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: const Color(0xffFCF7E8),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black, width: 4.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black, offset: Offset(1.0, 5.0))
          ]),

      /// scale the contents of the dialog as it expands and closes
      child: widget.show
          ? FittedBox(
              fit: BoxFit.contain,
              child: _AlertDialogContents(
                title: widget.title,
                next: widget.next,
                cancel: widget.cancel,
                child: widget.child,
              ),
            )
          : null,
    );
  }
}
