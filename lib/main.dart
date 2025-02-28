import 'package:flutter/material.dart';
// Mariam Omer
void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.brown[100],
        buttonTheme: ButtonThemeData(buttonColor: Colors.green),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = "";
  String _output = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _input = "";
        _output = "";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
      } else if (value == "=") {
        if (_operator.isNotEmpty) {
          _num2 = double.tryParse(_input) ?? 0;
          switch (_operator) {
            case "+":
              _output = (_num1 + _num2).toString();
              break;
            case "-":
              _output = (_num1 - _num2).toString();
              break;
            case "*":
              _output = (_num1 * _num2).toString();
              break;
            case "/":
              _output = (_num2 != 0) ? (_num1 / _num2).toString() : "Error";
              break;
          }
          _input = "";
          _operator = "";
        }
      } else if (["+", "-", "*", "/"].contains(value)) {
        if (_input.isNotEmpty) {
          _num1 = double.tryParse(_input) ?? 0;
          _operator = value;
          _input = "";
        }
      } else if (value == ".") {
        if (!_input.contains(".")) {
          _input += value;
        }
      } else {
        _input += value;
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(text),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          textStyle: TextStyle(fontSize: 24),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CalculatorApp"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              color: Colors.brown[200],
              child: Text(
                _input.isEmpty ? _output : _input,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
          ),
          Column(
            children: [
              Row(children: ["7", "8", "9", "/"].map(_buildButton).toList()),
              Row(children: ["4", "5", "6", "*"].map(_buildButton).toList()),
              Row(children: ["1", "2", "3", "-"].map(_buildButton).toList()),
              Row(children: ["0", ".", "=", "+"].map(_buildButton).toList()),
              Row(children: [_buildButton("C")]),
            ],
          ),
        ],
      ),
    );
  }
}
