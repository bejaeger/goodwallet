import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class MyPageTransitionSwitcher extends StatelessWidget {
  final Widget child;
  final bool reverse;
  const MyPageTransitionSwitcher(
      {Key? key, required this.child, required this.reverse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 300),
      reverse: reverse,
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
        );
      },
    );
  }
}
