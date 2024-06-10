import 'package:alpha/extensions.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/should_render_widget.dart';
import 'package:flutter/material.dart';

/// Creates a custom alert dialog widget in the style of the game.\
/// This widget should only be used by [AlphaScaffold] and not be
/// created anywhere else.
class AlphaAlertDialog extends StatefulWidget {
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
      duration:
          widget.show ? const Duration(milliseconds: 800) : Durations.short4,
      curve: widget.show ? Curves.elasticOut : Curves.decelerate,

      /// Animates the dialog expanding and closing, when the
      /// widget's `show` property changes
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

      /// Scale the contents of the dialog as it expands and closes.
      child: RenderIfTrue(
        condition: widget.show,
        child: FittedBox(
          fit: BoxFit.contain,
          child: _AlertDialogContents(
            title: widget.title,
            next: widget.next,
            cancel: widget.cancel,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// Helper class to encapsulate the parameters of the buttons of [AlphaAlertDialog].
class DialogButtonData {
  final String title;
  final double width;
  final double height;
  final void Function()? onTap;

  const DialogButtonData(
      {required this.title,
      this.width = 280.0,
      this.height = 60.0,
      this.onTap});

  /// Creates a [DialogButtonData] for a default `Cancel` button.
  static DialogButtonData cancel(BuildContext context) =>
      DialogButtonData(title: "Cancel", onTap: () => context.dismissDialog());

  /// Creates a [DialogButtonData] for a default `Confirm` button
  static DialogButtonData confirm({void Function()? onTap}) =>
      DialogButtonData(title: "Confirm", onTap: onTap);
}

/// Creates a widget for the contents of the [AlphaAlertDialog].
class _AlertDialogContents extends StatelessWidget {
  /// The top title of the alert dialog.
  final String title;

  /// The data of the `next` button of the alert dialog.
  final DialogButtonData? next;

  /// The data of the `cancel` button of the alert dialog.
  final DialogButtonData? cancel;

  /// The `child` to display below the title.
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            cancel != null
                ? AlphaButton(
                    width: cancel!.width,
                    height: cancel!.height,
                    title: cancel!.title,
                    onTap: cancel!.onTap,
                  )
                : const SizedBox(),
            RenderIfAllNotNull(
                nullables: [next, cancel], child: const SizedBox(width: 20.0)),
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
