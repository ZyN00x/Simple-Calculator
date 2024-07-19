import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class CalculatorBody extends StatefulWidget {
  const CalculatorBody({super.key});

  @override
  State<CalculatorBody> createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {
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
                child: const Text(
                  '0',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
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
                      onPressed: () {},
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

getAnswer() {
  String iMath = "123/23123/4+100";
  Expression exp = Expression.parse(iMath);
  final evaluator = const ExpressionEvaluator();
  double answer = evaluator.eval(exp, {});
  return answer.toString();
}

const String equalButtonColor = '#DC5F00';
const String backGroundColor = '#373A40';
const String screenColor = '#EEEEEE';
const String buttonColor = '#686D76';
