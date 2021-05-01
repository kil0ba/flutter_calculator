import 'package:calculator/providers/calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Results extends StatelessWidget {
  const Results({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: size.height - 600 > 0 ? size.height - 600 : 50,
          bottom: 40,
          right: 30,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Consumer<Calculator>(
            builder: (ctx, calculator, _) => FittedBox(
              child: Text(
                calculator.equation,
                style: TextStyle(
                  fontSize: 45,
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
