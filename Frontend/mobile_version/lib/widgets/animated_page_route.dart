import 'package:flutter/material.dart';

class AnimatedPageRoute extends PageRouteBuilder {
  final Widget widget;
  final Alignment alignment;
  AnimatedPageRoute({required this.widget, required this.alignment})
      : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secAnimation,
            Widget child,
          ) {
            // animation =
            //     CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
            return ScaleTransition(
              alignment: alignment,
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation) {
            return widget;
          },
        );
}
