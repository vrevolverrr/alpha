import 'package:alpha/ui/common/alpha_alert_dialog.dart';
import 'package:alpha/ui/common/alpha_snackbar.dart';
import 'package:alpha/ui/common/alpha_title.dart';
import 'package:alpha/ui/common/should_render_widget.dart';
import 'package:flutter/material.dart';

/// Creates a widget that acts as the scaffolding for each screen of the game.
///
/// This widget is built on top of a [Scaffold], with custom implementations of \
/// [AlertDialog] using [AlphaAlertDialog] and [Snackbar] using [AlphaSnackbar].
///
/// To display the [AlphaAlertDialog] or [AlphaSnackbar], obtain
/// the [AlphaScaffoldState] for the current [BuildContext] via
/// [AlphaScaffold.of] and use [AlphaScaffoldState.showDialog] and
/// [AlphaScaffoldState.showSnackbar] methods respectively.
///
/// To obtain the [AlphaScaffoldState] from the [BuildContext] of the build
/// method in which the [AlphaScaffold] is being built, wrap the widget in a
/// [Builder] instead and access the new context from the [Builder].
class AlphaScaffold extends StatefulWidget {
  /// The top title to be displayed.
  final String title;

  /// The alignment used for the [Column] of the contents.
  final MainAxisAlignment? mainAxisAlignment;

  /// The function that is called when the back button is pressed.\
  /// Note that the back button is not showed if `onTapBack` is null.
  final void Function()? onTapBack;

  /// The button that is shown at the bottom right corner of the screen.\
  /// Typically an [AlphaButton] is used.
  final Widget? next;

  /// The [AlphaSnackbar] message to show when the screen is first rendered.\
  /// The animation is played after a fixed delay after
  /// calling [AlphaScaffoldState.initState].
  final String? landingMessage;

  /// The children to be spreaded in the [Column] of the contents.
  final List<Widget> children;

  const AlphaScaffold(
      {super.key,
      required this.title,
      this.mainAxisAlignment,
      this.onTapBack,
      this.next,
      this.landingMessage,
      required this.children});

  /// Finds the [AlphaScaffoldState] from the closest of this class that
  /// encloses the given [BuildContext].
  /// Call this method to obtain an [AlphaScaffoldState] to
  /// display [AlphaAlertDialog] and [AlphaSnackbar].
  static AlphaScaffoldState of(BuildContext context) {
    AlphaScaffoldState? result =
        context.findAncestorStateOfType<AlphaScaffoldState>();

    if (result == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
          'AlphaScaffold.of() called with a context that does not contain a AlphaScaffold.',
        ),
        context.describeElement('The context used was'),
      ]);
    }

    return result;
  }

  @override
  State<AlphaScaffold> createState() => AlphaScaffoldState();
}

class AlphaScaffoldState extends State<AlphaScaffold>
    with SingleTickerProviderStateMixin {
  /// Placeholder dialog builder, will be replaced when showDialog() is called.
  AlphaDialogBuilder _dialogBuilder =
      const AlphaDialogBuilder(title: "", child: SizedBox());

  /// setState will be called on this flag to expand and close the dialog.
  bool _showAlphaDialog = false;

  late final AnimationController _snackbarController;

  /// Placeholder message for the snackbar, will be replaced when showSnackbar() is called.
  String _snackbarMessage = "";

  void showSnackbar(
      {required String message,
      Duration duration = const Duration(seconds: 1)}) {
    if (_snackbarController.isAnimating) return;

    setState(() => _snackbarMessage = message);

    _snackbarController.forward();
    Future.delayed(duration, () => _snackbarController.reverse());
  }

  void dismissSnackbar() {
    if (_snackbarController.isCompleted) {
      _snackbarController.reverse();
    }
  }

  void showDialog(AlphaDialogBuilder builder) {
    setState(() {
      _dialogBuilder = builder;
      _showAlphaDialog = true;
    });
  }

  void dismissDialog() {
    setState(() => _showAlphaDialog = false);
  }

  @override
  void initState() {
    _snackbarController = AnimationController(vsync: this);

    if (widget.landingMessage != null) {
      Future.delayed(
          const Duration(milliseconds: 500),
          () => showSnackbar(
              message: widget.landingMessage!,
              duration: const Duration(seconds: 3)));
    }
    super.initState();
  }

  @override
  void dispose() {
    _snackbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              const SizedBox(height: 35.0),
              _AlphaScaffoldAppBar(
                  title: widget.title, onTapBack: widget.onTapBack),
              _AlphaScaffoldContents(
                  mainAxisAlignment: widget.mainAxisAlignment,
                  next: widget.next,
                  children: widget.children)
            ],
          ),
          _AlphaScaffoldSnackbar(
              snackbarMessage: _snackbarMessage,
              snackbarController: _snackbarController),
          RenderIfTrue(
              condition: _showAlphaDialog,
              child: Container(color: const Color.fromARGB(120, 86, 86, 86))),
          _AlphaScaffoldAlphaDialog(
              showAlphaDialog: _showAlphaDialog, dialogBuilder: _dialogBuilder),
        ],
      ),
    );
  }
}

class _AlphaScaffoldAppBar extends StatelessWidget {
  final String title;
  final void Function()? onTapBack;

  const _AlphaScaffoldAppBar({required this.title, required this.onTapBack});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RenderIfNotNull(
            nullable: onTapBack,
            child: _AlphaScaffoldTapBack(onTapBack: onTapBack)),
        Align(
          alignment: Alignment.center,
          child: AlphaTitle(
            title,
            fontSize: 40.0,
          ),
        ),
      ],
    );
  }
}

class _AlphaScaffoldTapBack extends StatelessWidget {
  final void Function()? onTapBack;
  const _AlphaScaffoldTapBack({required this.onTapBack});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: onTapBack,
          child: const Icon(Icons.arrow_back_rounded, size: 38.0),
        ),
      ),
    );
  }
}

class _AlphaScaffoldContents extends StatelessWidget {
  final MainAxisAlignment? mainAxisAlignment;
  final Widget? next;
  final List<Widget> children;

  const _AlphaScaffoldContents(
      {required this.mainAxisAlignment,
      required this.children,
      required this.next});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: [
        // The SizedBox.expand will give constraints to the Column
        SizedBox.expand(
          child: Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: children,
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: const EdgeInsets.only(right: 50.0, bottom: 50.0),
                child: next)),
      ],
    ));
  }
}

class _AlphaScaffoldSnackbar extends StatelessWidget {
  final String snackbarMessage;
  final AnimationController snackbarController;

  const _AlphaScaffoldSnackbar(
      {required this.snackbarMessage, required this.snackbarController});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: AlphaSnackbar(
            message: snackbarMessage, controller: snackbarController));
  }
}

class _AlphaScaffoldAlphaDialog extends StatelessWidget {
  final AlphaDialogBuilder dialogBuilder;
  final bool showAlphaDialog;

  const _AlphaScaffoldAlphaDialog(
      {required this.showAlphaDialog, required this.dialogBuilder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Align(
        alignment: Alignment.center,
        child: AlphaAlertDialog(
          title: dialogBuilder.title,
          show: showAlphaDialog,
          next: dialogBuilder.next,
          cancel: dialogBuilder.cancel,
          child: dialogBuilder.child,
        ),
      ),
    );
  }
}

class AlphaDialogBuilder {
  final String title;
  final Widget child;
  final DialogButtonData? next;
  final DialogButtonData? cancel;

  const AlphaDialogBuilder(
      {required this.title, required this.child, this.next, this.cancel});
}
