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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 150,
                padding: const EdgeInsets.all(8.0),
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
              flex: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.2,
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
                              hexToColor(ifEqualButton(buttons[index])),
                        ),
                        child: Text(
                          buttons[index],
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      );
                    },
                  ),
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
        'DEL',
      ];

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'DEL') {
        if (currentExpression.isNotEmpty) {
          currentExpression =
              currentExpression.substring(0, currentExpression.length - 1);
        }
      } else if (buttonText == 'C') {
        currentExpression = '';
      } else if (buttonText == '=') {
        if (!isValidExpression(currentExpression)) {
          currentExpression = "Invalid Input";
        } else if (currentExpression == '') {
          currentExpression = "No Input";
        } else {
          currentExpression = getAnswer(currentExpression);
          isAnswered = true;
        }
      } else {
        if ((isAnswered && !isOngoingOperation(currentExpression)) ||
            currentExpression == "Invalid Input" ||
            currentExpression == "No Input") {
          currentExpression = '';
          isAnswered = false;
        }

        currentExpression += buttonText;
      }
    });
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF' + hex;
    }
    return Color(int.parse(hex, radix: 16));
  }

  String ifEqualButton(String symbol) {
    if (symbol == '=') {
      return equalButtonColor;
    }
    return buttonColor;
  }

  String getAnswer(String iMath) {
    iMath = iMath.replaceAll('x', '*');
    Expression exp = Expression.parse(iMath);
    final evaluator = ExpressionEvaluator();
    var answer = evaluator.eval(exp, {});
    return answer.toString();
  }

  bool isOngoingOperation(String expression) {
    return !['-', 'x', '+', '/'].contains(expression);
  }

  bool isValidExpression(String currentExpression) {
    if (currentExpression.startsWith('/') ||
        currentExpression.startsWith('x')) {
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
}

const String equalButtonColor = '#DC5F00';
const String backGroundColor = '#373A40';
const String screenColor = '#EEEEEE';
const String buttonColor = '#686D76';
