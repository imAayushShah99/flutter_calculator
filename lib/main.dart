import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = '0';
  String result = '0';
  String expression = '';

  buttonPressed(String buttonLabel) {
    setState(() {
      if (buttonLabel == 'C') {
        result = '0';
        equation = '0';
      }
      else if (buttonLabel == 'Back') {
        equation = equation.substring(0, equation.length - 1);
        result = '';
        if (equation == '') {
          equation = '0';
        }
      }
      else if (buttonLabel == '=') {
        expression = equation;

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'ERROR';
        }
      } else {
        if (equation == '0' || equation == '00') {
          equation = buttonLabel;
        } else {
          equation = equation + buttonLabel;
        }
      }
    });
  }

  Widget buildButton({String buttonLabel, Color buttonColor, double height}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MaterialButton(
        focusElevation: 15,
//        elevation: 15,
        height: MediaQuery.of(context).size.height * height,
        textColor: Colors.black,
        color: buttonColor,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            side: BorderSide(), borderRadius: BorderRadius.circular(10)),
        onPressed:(){ buttonPressed(buttonLabel);},
        child: Text(
          buttonLabel,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        appBar: AppBar(
          title: Text('Calculator'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Text(
                equation,
                maxLines: 2,
                style: TextStyle(fontSize: 38),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Text(
                result,
                maxLines: 1,
                style: TextStyle(fontSize: 48),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton(
                          buttonLabel: 'C',
                          buttonColor: Colors.red,
                          height: .1,
                        ),
                        buildButton(
                          buttonLabel: 'Back',
                          buttonColor: Colors.blue,
                          height: .1,
                        ),
                        buildButton(
                          buttonLabel: '+',
                          buttonColor: Colors.blue,
                          height: .1,
                        ),
                      ]),
                      TableRow(children: [
                        buildButton(
                          buttonLabel: '7',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                        buildButton(
                          buttonLabel: '8',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                        buildButton(
                          buttonLabel: '9',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                      ]),
                      TableRow(children: [
                        buildButton(
                          buttonLabel: '4',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                        buildButton(
                          buttonLabel: '5',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                        buildButton(
                          buttonLabel: '6',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                      ]),
                      TableRow(children: [
                        buildButton(
                          buttonLabel: '1',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                        buildButton(
                          buttonLabel: '2',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                        buildButton(
                          buttonLabel: '3',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                      ]),
                      TableRow(children: [
                        buildButton(
                          buttonLabel: '0',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                        buildButton(
                          buttonLabel: '.',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                        buildButton(
                          buttonLabel: '00',
                          buttonColor: Colors.deepPurple[50],
                          height: .1,
                        ),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton(
                          buttonLabel: '/',
                          buttonColor: Colors.blue,
                          height: .1,
                        ),
                      ]),
                      TableRow(children: [
                        buildButton(
                          buttonLabel: '*',
                          buttonColor: Colors.blue,
                          height: .1,
                        ),
                      ]),
                      TableRow(children: [
                        buildButton(
                          buttonLabel: '-',
                          buttonColor: Colors.blue,
                          height: .1,
                        ),
                      ]),
                      TableRow(children: [
                        buildButton(
                          buttonLabel: '=',
                          buttonColor: Colors.red,
                          height: .21,
                        ),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
