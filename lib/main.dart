import 'package:calculatorapp/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var userQues= '';
  var userAns= '';

  final List<String> buttons = 
  [
    'C', 'DEL', '%', '/', 
    '9', '8', '7', '*',
    '6', '5', '4', '+',
    '3', '2', '1', '-',
    '0', '.', 'ANS', '=',
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget> [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQues, style: TextStyle(fontSize: 20, color: Colors.white),)),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAns, style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),), )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
                itemBuilder: (BuildContext context, int index){
                  //clear button
                  if (index==0){
                    return MyButton(
                      buttonTapped: (){
                        setState(() {
                          userQues='';
                        });
                      },
                    buttonText: buttons[index],
                    color: Colors.amber,
                    textColor: Colors.grey[800],
                    );
                  }
                  //delete button
                  else if (index==1){
                    return MyButton(
                      buttonTapped: (){
                        setState(() {
                          userQues=userQues.substring(0,userQues.length-1);
                        });
                      },
                    buttonText: buttons[index],
                    color: Colors.yellow[600],
                    textColor: Colors.grey[800],
                    );
                  }
                  //equal button
                  else if (index== buttons.length-1){
                    return MyButton(
                      buttonTapped: (){
                        setState(() {
                          equalPressed();
                        });
                      },
                    buttonText: buttons[index],
                    color: Colors.yellow[600],
                    textColor: Colors.grey[800],
                    );
                  }
                  //all other buttons
                  else{
                    return MyButton(
                      buttonTapped: (){
                        setState(() {
                          userQues += buttons[index];
                        });
                      },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index]) ? Colors.yellow[800] : Colors.white,
                    textColor: isOperator(buttons[index]) ? Colors.white: Colors.grey[800],
                    );
                  }
                },
                ),
            ),
          ),
        ]
      )
    );
  }
  bool isOperator(String x){
    if (x == '%' || x == '/' || x == '*' || x == '+' || x == '-' || x == '%' || x == '='){
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalQues= userQues;

    Parser p = Parser();
    Expression exp = p.parse(finalQues);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAns = eval.toString();

  }


}
