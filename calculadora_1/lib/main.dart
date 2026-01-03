import 'package:calculadora_1/widgets/CalcButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalcApp());
}

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  String _history = "";
  String _expression = "";

  void clear(String text) {
    setState(() {
      _expression = "";
    });
  }

  void clearAll(String text) {
    setState(() {
      _history = "";
      _expression = "";
    });
  }

  void evaluate(String text) {
    ExpressionParser parser = GrammarParser();
    Expression exp = parser.parse(_expression);
    ContextModel cm = ContextModel();
    var evaluator = RealEvaluator(cm);
    num eval = evaluator.evaluate(exp);
    setState(() {
      _history = _expression;
      _expression = eval.toString();
    });
  }

  void numClicked(String text) {
    setState(() {
      _expression += text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculadora",
      home: Scaffold(
        backgroundColor: const Color(0xFF1a1e22),
        body: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: const Alignment(1.0, 1.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    _history,
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFF545F61),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: const Alignment(1.0, 1.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _expression,
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                        fontSize: 28.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Calcbutton(
                    bgColor: 0xFFB79A00,
                    text: "CE",
                    callback: clearAll,
                    textSize: 15,
                  ),
                  Calcbutton(
                    bgColor: 0xFFE3303A,
                    text: "⌫",
                    callback: clear,
                    textSize: 15,
                  ),
                  Calcbutton(
                    bgColor: 0xFF646564,
                    text: "%",
                    callback: numClicked,
                    textSize: 15,
                  ),
                  Calcbutton(
                    bgColor: 0xFF646564,
                    text: "/",
                    callback: numClicked,
                    textSize: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Calcbutton(text: "7", callback: numClicked, textSize: 15),
                  Calcbutton(text: "8", callback: numClicked, textSize: 15),
                  Calcbutton(text: "9", callback: numClicked, textSize: 15),
                  Calcbutton(
                    bgColor: 0xFF646564,
                    text: "*",
                    callback: numClicked,
                    textSize: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Calcbutton(text: "4", callback: numClicked, textSize: 15),
                  Calcbutton(text: "5", callback: numClicked, textSize: 15),
                  Calcbutton(text: "6", callback: numClicked, textSize: 15),
                  Calcbutton(
                    bgColor: 0xFF646564,
                    text: "-",
                    callback: numClicked,
                    textSize: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Calcbutton(text: "1", callback: numClicked, textSize: 15),
                  Calcbutton(text: "2", callback: numClicked, textSize: 15),
                  Calcbutton(text: "3", callback: numClicked, textSize: 15),
                  Calcbutton(
                    bgColor: 0xFF646564,
                    text: "+",
                    callback: numClicked,
                    textSize: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Calcbutton(text: ".", callback: numClicked, textSize: 15),
                  Calcbutton(text: "0", callback: numClicked, textSize: 15),
                  Calcbutton(text: "00", callback: numClicked, textSize: 15),
                  Calcbutton(
                    bgColor: 0xFF00BF45,
                    text: "=",
                    callback: evaluate,
                    textSize: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
