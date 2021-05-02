import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator with ChangeNotifier {
  String _equation = '0';

  String get equation {
    return _equation;
  }

  void addSymbolToCurrentNumber(String symbol) {
    if (_equation == '0' || _equation == 'error' || _equation == 'Infinity') {
      if (symbol == '00' || int.tryParse(symbol) == null) {
        _equation = '0';
      } else {
        _equation = symbol;
      }
    } else {
      final lastSymbol =
          _equation.trimRight()[_equation.trimRight().length - 1];
      // check for two operations
      if (int.tryParse(symbol) == null &&
          int.tryParse(lastSymbol) == null &&
          (lastSymbol != '%' && symbol != '% ')) {
        return;
      }
      // check for second dot
      final splittedEq = _equation.split(' ');
      final lastNum = splittedEq[splittedEq.length - 1];
      if (lastNum.contains('.') && symbol == '.') {
        return;
      }
      _equation += symbol;
    }
    notifyListeners();
  }

  void deleteLastSymbolFromEquation() {
    if (_equation.length == 1 || _equation == 'error') {
      _equation = '0';
    } else {
      var editedEquation = _equation.trimRight();
      editedEquation = editedEquation.substring(0, editedEquation.length - 1);
      _equation = editedEquation.trimRight();
    }
    notifyListeners();
  }

  void calculate() {
    try {
      var parsedEquation = _equation.replaceAll('%', '/ 100');
      parsedEquation = parsedEquation.replaceAll('÷', '/');
      parsedEquation = parsedEquation.replaceAll('x', '*');

      Parser p = Parser();
      Expression exp = p.parse(parsedEquation);

      ContextModel cm = ContextModel();
      final result = exp.evaluate(EvaluationType.REAL, cm).toString();
      _equation = result == '0.0' ? '0' : result;
    } catch (e) {
      _equation = 'error';
    }

    notifyListeners();
  }

  void clearEquation() {
    _equation = '0';
    notifyListeners();
  }
}
