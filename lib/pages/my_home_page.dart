import 'package:calculator/components/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userInput = ""; // Stores the current input
  String result = "0"; // Stores the calculation result

  final List<String> buttons = [
    'C',
    'Del',
    '%',
    'log', // Replaced "OFF" with "log"
    '(',
    ')',
    '/',
    '*',
    '7',
    '8',
    '9',
    '-',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '=',
    '0',
    '.',
  ];

  // Function to handle button presses
  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Clear input and result
        userInput = "";
        result = "0";
      } else if (buttonText == "Del") {
        // Remove the last character
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (buttonText == "=") {
        // Evaluate the expression
        result = calculateResult();
      } else {
        // Append the button text to the input
        userInput += buttonText;
      }
    });
  }

  // Function to evaluate the expression
  String calculateResult() {
    try {
      // Replace custom operators with standard math expressions
      String finalInput = userInput.replaceAll('x', '*');

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
                    userInput, // Display the current input
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    result, // Display the calculation result
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
                  // Assign different colors based on the button type
                  Color buttonColor = Colors.grey[800]!;
                  Color textColor = Colors.white;

                  if (index < 4) {
                    // First row (special buttons)
                    buttonColor = Colors.redAccent;
                    textColor = Colors.white;
                  } else if (index % 4 == 3 ||
                      buttons[index] == "(" ||
                      buttons[index] == ")") {
                    // Right-most column (operators) and brackets
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
