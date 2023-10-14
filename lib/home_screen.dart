import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userInput = '';
  var answer = '';

  void equalPressed() {
    String finalUserInput = userInput;
    finalUserInput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      answer = eval.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userInput,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        child: Text(
                          answer,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    for (var row in buttonRows) buildButtonRow(row),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonRow(List<String> row) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          for (String title in row) buildButton(title),
        ],
      ),
    );
  }

  Widget buildButton(String title) {
    return MyButton(
      title: title,
      onPress: () {
        if (title == 'AC') {
          setState(() {
            userInput = '';
            answer = '0';
          });
        } else if (title == '=') {
          equalPressed();
        } else {
          setState(() {
            userInput += title;
          });
        }
      },
      color: isOperator(title) ? Colors.blue : null,
    );
  }

  bool isOperator(String title) {
    return ['+', '-', 'x', '/', '%'].contains(title);
  }

  static const buttonRows = [
    ['AC', '+/-', '%', '/'],
    ['7', '8', '9', 'x'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['0', '.', 'DL', '='],
  ];
}
