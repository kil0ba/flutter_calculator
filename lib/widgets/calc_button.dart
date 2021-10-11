import '../utility/platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class CalcButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  CalcButton({
    @required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoButton(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
            color: Color.fromARGB(5, 256, 256, 256),
          ),
          width: 65,
          height: 65,
          child: Center(
            child: Transform.scale(
              scale: 1.5,
              child: child,
            ),
          ),
        ),
        onPressed: () async {
          onPressed();
          if (isMobile() && await Vibration.hasVibrator()) {
            Vibration.vibrate(duration: 3);
          }
        },
        padding: EdgeInsets.only(top: 0),
      ),
    );
  }
}
