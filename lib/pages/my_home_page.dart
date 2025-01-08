import 'package:calculator/components/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

/// A stateful widget that represents the home page of the calculator app.
class MyHomePage extends StatefulWidget {
  /// Creates an instance of [MyHomePage].
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// The state class for [MyHomePage].
class _MyHomePageState extends State<MyHomePage> {
  /// Stores the current input from the user.
  String userInput = "";

  /// Stores the calculation result.
  String result = "0";

  /// A list of button labels for the calculator.
  final List<String> buttons = [
    'C', 'Del', '%', '😊', '7', '8', '9', '/', '4', '5', '6', '*', '1', '2', '3', '-', '0', '.', '=', '+',
  ];

  /// Handles button presses and updates the state accordingly.
  ///
  /// [buttonText] is the label of the button that was pressed.
  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        userInput = "";
        result = "0";
      } else if (buttonText == "Del") {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (buttonText == "=") {
        result = calculateResult();
      } else {
        userInput += buttonText;
      }
    });
  }

  /// Evaluates the mathematical expression in [userInput] and returns the result.
  ///
  /// Returns the result as a string. If there's an error in evaluation, returns "Error".
  String calculateResult() {
    try {
      String finalInput = userInput.replaceAll('^', '**');
      Parser parser = Parser();
      Expression exp = parser.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Display section
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    userInput,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    result,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          // Button grid section
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1,
                ),
                itemCount: buttons.length,
                itemBuilder: (BuildContext context, int index) {
                  Color buttonColor = Colors.grey[800]!;
                  Color textColor = Colors.white;

                  if (index < 4) {
                    buttonColor = Colors.redAccent;
                    textColor = Colors.white;
                  } else if (index % 4 == 3) {
                    buttonColor = Colors.orange;
                    textColor = Colors.white;
                  }

                  return GestureDetector(
                    onTap: () => onButtonPressed(buttons[index]),
                    child: MyButton(
                      text: buttons[index],
                      color: buttonColor,
                      textcolor: textColor,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
