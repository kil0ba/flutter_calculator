import 'package:calculator/providers/calculator.dart';
import 'package:calculator/utility/constants.dart';
import 'package:calculator/widgets/calc_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorButtons extends StatefulWidget {
  const CalculatorButtons({Key key}) : super(key: key);

  @override
  _CalculatorButtonsState createState() => _CalculatorButtonsState();
}

class _CalculatorButtonsState extends State<CalculatorButtons>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    offset = Tween<Offset>(begin: Offset(0, 2), end: Offset(0.0, 0.0))
        .animate(controller);

    Future.delayed(Duration(milliseconds: 1)).then(
      (value) => {
        setState(() {
          controller.forward();
        })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<Calculator>(context, listen: false);
    final orientation = MediaQuery.of(context).orientation;

    Widget numButtonBuilder(String num) {
      return CalcButton(
        child: Text(
          num,
          style: numeralStyle,
        ),
        onPressed: () => calc.addSymbolToCurrentNumber(num),
      );
    }

    Widget transitionBuilder() {
      return SlideTransition(
        position: offset,
        child: Container(
          constraints: BoxConstraints(maxHeight: 500),
          width: orientation == Orientation.portrait ? double.infinity : 400,
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey6,
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.elliptical(55.0, 40.0),
              topRight: const Radius.elliptical(55.0, 40.0),
            ),
          ),
          padding: EdgeInsets.only(top: 15, bottom: 4),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CalcButton(
                      child: Text(
                        'AC',
                        style: TextStyle(
                          color: CupertinoColors.activeGreen,
                        ),
                      ),
                      onPressed: calc.clearEquation,
                    ),
                    CalcButton(
                      child: Icon(
                        CupertinoIcons.delete_left,
                        color: CupertinoColors.systemGreen,
                      ),
                      onPressed: calc.deleteLastSymbolFromEquation,
                    ),
                    CalcButton(
                      child: Icon(
                        CupertinoIcons.percent,
                        color: CupertinoColors.activeGreen,
                      ),
                      onPressed: () => calc.addSymbolToCurrentNumber('% '),
                    ),
                    CalcButton(
                      child: Icon(
                        CupertinoIcons.divide,
                        color: CupertinoColors.systemRed,
                      ),
                      onPressed: () => calc.addSymbolToCurrentNumber(' ÷ '),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    numButtonBuilder('7'),
                    numButtonBuilder('8'),
                    numButtonBuilder('9'),
                    CalcButton(
                      child: Icon(
                        CupertinoIcons.xmark,
                        color: CupertinoColors.systemRed,
                      ),
                      onPressed: () => calc.addSymbolToCurrentNumber(' x '),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    numButtonBuilder('4'),
                    numButtonBuilder('5'),
                    numButtonBuilder('6'),
                    CalcButton(
                      child: Icon(
                        CupertinoIcons.minus,
                        color: CupertinoColors.systemRed,
                      ),
                      onPressed: () => calc.addSymbolToCurrentNumber(' - '),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    numButtonBuilder('1'),
                    numButtonBuilder('2'),
                    numButtonBuilder('3'),
                    CalcButton(
                      child: Icon(
                        CupertinoIcons.plus,
                        color: CupertinoColors.systemRed,
                      ),
                      onPressed: () => calc.addSymbolToCurrentNumber(' + '),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    numButtonBuilder('00'),
                    numButtonBuilder('0'),
                    numButtonBuilder('.'),
                    CalcButton(
                      child: Icon(
                        CupertinoIcons.equal,
                        color: CupertinoColors.systemRed,
                      ),
                      onPressed: () {
                        final isShowMeme = calc.calculate();
                        if (isShowMeme) {
                          showCupertinoDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              content: const Text(
                                PASTE,
                              ),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: const Text(SHIT_WORD),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return orientation == Orientation.portrait
        ? Expanded(child: transitionBuilder())
        : transitionBuilder();
  }
}

const TextStyle numeralStyle = TextStyle(
  color: CupertinoColors.black,
);
