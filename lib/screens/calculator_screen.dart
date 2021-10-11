import 'package:calculator/providers/calculator.dart';
import 'package:calculator/widgets/calculator_buttons.dart';
import 'package:calculator/widgets/results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    List<Widget> childrenBuilder() {
      return [
        Results(),
        CalculatorButtons(),
      ];
    }

    return CupertinoPageScaffold(
      child: ChangeNotifierProvider(
        create: (ctx) => Calculator(),
        child: Container(
          padding: EdgeInsets.only(top: 5),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            bottom: false,
            child: orientation == Orientation.portrait
                ? Column(
                    children: childrenBuilder(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: childrenBuilder(),
                  ),
          ),
        ),
      ),
    );
  }
}
