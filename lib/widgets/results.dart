import 'package:calculator/providers/calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Results extends StatelessWidget {
  const Results() : super();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      constraints: orientation == Orientation.portrait
          ? null
          : BoxConstraints(maxWidth: size.width - 400),
      height: orientation == Orientation.portrait
          ? size.height - 500 > 0
              ? size.height - 500
              : 50
          : null,
      child: Padding(
        padding: EdgeInsets.only(
          right: 15,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Consumer<Calculator>(
            builder: (ctx, calculator, _) => FittedBox(
              child: Text(
                calculator.equation,
                style: TextStyle(
                  fontSize: 85,
                  color: CupertinoTheme.of(context).primaryContrastingColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
