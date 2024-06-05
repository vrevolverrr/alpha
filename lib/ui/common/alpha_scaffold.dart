import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_dialog.dart';
import 'package:alpha/ui/common/alpha_snackbar.dart';
import 'package:alpha/ui/common/alpha_title.dart';
import 'package:flutter/material.dart';

class AlphaScaffold extends StatefulWidget {
  final String title;
  final MainAxisAlignment? mainAxisAlignment;
  final void Function()? onTapBack;
  final Widget? next;
  final List<Widget> children;

  const AlphaScaffold(
      {super.key,
      required this.title,
      this.mainAxisAlignment,
      this.onTapBack,
      this.next,
      required this.children});

  static AlphaScaffoldState of(BuildContext context) {
    AlphaScaffoldState? result =
        context.findAncestorStateOfType<AlphaScaffoldState>();

    if (result == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
          'AlphaScaffold.of() called with a context that does not contain a AlphaScaffold.',
        ),
        ErrorDescription(
          'No AlphaScaffold ancestor could be found starting from the context that was passed to AlphaScaffold.of(). '
          'This usually happens when the context provided is from the same StatefulWidget as that '
          'whose build function actually creates the Scaffold widget being sought.',
        ),
        context.describeElement('The context used was'),
      ]);
    }

    return result;
  }

  @override
  State<AlphaScaffold> createState() => AlphaScaffoldState();
}

class AlphaScaffoldState extends State<AlphaScaffold> {
  AlphaDialogBuilder _dialogBuilder =
      const AlphaDialogBuilder(title: "", child: SizedBox());
  bool _showAlertDialog = false;

  void showSnackbar() {}

  void showAlphaDialog(AlphaDialogBuilder builder) {
    setState(() {
      _dialogBuilder = builder;
      _showAlertDialog = true;
    });
  }

  void dismissAlphaDialog() {
    setState(() => _showAlertDialog = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              const SizedBox(height: 35.0),
              Stack(
                children: <Widget>[
                  widget.onTapBack != null
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: GestureDetector(
                              onTap: widget.onTapBack,
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 38.0),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Align(
                    alignment: Alignment.center,
                    child: AlphaTitle(
                      widget.title,
                      fontSize: 40.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Stack(
                children: [
                  SizedBox.expand(
                    child: Column(
                      mainAxisAlignment:
                          widget.mainAxisAlignment ?? MainAxisAlignment.start,
                      children: widget.children,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(right: 50.0, bottom: 50.0),
                          child: widget.next)),
                ],
              ))
            ],
          ),
          const Align(
              alignment: Alignment.bottomCenter, child: AlphaSnackbar()),
          _showAlertDialog
              ? Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(120, 86, 86, 86)),
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Align(
              alignment: Alignment.center,
              child: AlphaAlertDialog(
                title: _dialogBuilder.title,
                show: _showAlertDialog,
                next: _dialogBuilder.next,
                cancel: _dialogBuilder.cancel,
                child: _dialogBuilder.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlphaDialogBuilder {
  final String title;
  final Widget child;
  final AlertButtonData? next;
  final AlertButtonData? cancel;

  const AlphaDialogBuilder(
      {required this.title, required this.child, this.next, this.cancel});
}
