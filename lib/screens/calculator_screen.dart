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

    List<Widget> childredBuilder() {
      return [
        Results(),
        CalculatorButtons(),
      ];
    }

    return CupertinoPageScaffold(
      child: SafeArea(
        bottom: false,
        child: ChangeNotifierProvider(
          create: (ctx) => Calculator(),
          child: Container(
            width: double.infinity,
            child: orientation == Orientation.portrait
                ? Column(
                    children: childredBuilder(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: childredBuilder(),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
