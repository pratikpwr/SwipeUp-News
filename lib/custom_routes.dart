import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';

class SlideFromLeftPageRoute extends PageRouteBuilder{
  Widget widget;
  SlideFromLeftPageRoute({this.widget}) : super(

      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return effectMap[PageTransitionType.slideInRight](Curves.linear, animation, secondaryAnimation, child);
      }

  );
}

class SlideFromRightPageRoute extends PageRouteBuilder{
  Widget widget;
  SlideFromRightPageRoute({this.widget}) : super(

      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return effectMap[PageTransitionType.slideInLeft](Curves.linear, animation, secondaryAnimation, child);
      }

  );
}