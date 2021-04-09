import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// Wrap the entire app with this widget to allow for a text field
// to be unfocused if the user clicks somewhere else
// @see https://github.com/flutter/flutter/issues/32433

class Unfocuser extends StatelessWidget {
  const Unfocuser({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (e) {
        final rb = context.findRenderObject() as RenderBox;
        final result = BoxHitTestResult();
        rb.hitTest(result, position: e.position);

        for (final e in result.path) {
          if (e.target is RenderEditable ||
              e.target is IgnoreUnfocuserRenderBox) {
            return;
          }
        }

        final primaryFocus = FocusManager.instance.primaryFocus!;

        if (primaryFocus.context!.widget is EditableText) {
          primaryFocus.unfocus();
        }
      },
      child: child,
    );
  }
}

class IgnoreUnfocuser extends SingleChildRenderObjectWidget {
  IgnoreUnfocuser({required this.child}) : super(child: child);

  final Widget child;

  @override
  IgnoreUnfocuserRenderBox createRenderObject(BuildContext context) =>
      IgnoreUnfocuserRenderBox();
}

class IgnoreUnfocuserRenderBox extends RenderPointerListener {}
