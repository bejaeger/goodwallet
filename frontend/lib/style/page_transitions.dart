import 'package:flutter/material.dart';

Widget customTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return CustomTransition(child: child);
}

class CustomTransition extends StatefulWidget {
  final Widget child;

  const CustomTransition({Key? key, required this.child}) : super(key: key);
  @override
  _CustomTransitionState createState() => _CustomTransitionState();
}

class _CustomTransitionState extends State<CustomTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(opacity: _animation as Animation<double>, child: widget.child);
  }
}
