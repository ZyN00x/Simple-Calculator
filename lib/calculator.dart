import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class CalculatorBody extends StatefulWidget {
  const CalculatorBody({super.key});

  @override
  State<CalculatorBody> createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {
  String currentExpression = '';
  bool isAnswered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor(backGroundColor),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: hexToColor(screenColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  currentExpression,
                  style: const TextStyle(
                      fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        onButtonPressed(buttons[index]);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(20),
                        backgroundColor:
                            hexToColor(isEqualButton(buttons[index])),
                      ),
                      child: Text(
                        buttons[index],
                        style:
                            const TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> get buttons => [
        '7',
        '8',
        '9',
        '/',
        '4',
        '5',
        '6',
        'x',
        '1',
        '2',
        '3',
        '-',
        'C',
        '0',
        '=',
        '+',
      ];

  onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        currentExpression = '';
      } else if (buttonText == '=') {
        if (!WrongExpression(currentExpression)) {
          currentExpression = "Invalid Input";
        } else {
          currentExpression = getAnswer(currentExpression);
          isAnswered = true;
        }
      } else {
        if ((isAnswered == true && !onGoingOperation(currentExpression)) ||
            currentExpression == "Invalid Input") {
          currentExpression = '';
          isAnswered = false;
        }
        currentExpression += buttonText;
      }
    });
  }
}

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF' + hex;
  }
  return Color(int.parse(hex, radix: 16));
}

isEqualButton(String symbols) {
  if (symbols == '=') {
    return equalButtonColor;
  }
  return buttonColor;
}

getAnswer(String iMath) {
  iMath = iMath.replaceAll('x', '*');
  Expression exp = Expression.parse(iMath);
  final evaluator = ExpressionEvaluator();
  double answer = evaluator.eval(exp, {});
  return answer.toString();
}

onGoingOperation(String expression) {
  if (expression != '-' ||
      expression != 'x' ||
      expression != '+' ||
      expression != '/') {
    return true;
  }
  return false;
}

WrongExpression(String currentExpression) {
  if (currentExpression.startsWith('/') || currentExpression.startsWith('x')) {
    return false;
  }

  if (currentExpression.endsWith('/') ||
      currentExpression.endsWith('x') ||
      currentExpression.endsWith('-') ||
      currentExpression.endsWith('+')) {
    return false;
  }

  return true;
}

const String equalButtonColor = '#DC5F00';
const String backGroundColor = '#373A40';
const String screenColor = '#EEEEEE';
const String buttonColor = '#686D76';
