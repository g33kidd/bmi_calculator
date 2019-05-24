import 'dart:math';

import 'package:bmi_calculator/info.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as constants;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BMI Calculator",
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          display1: TextStyle(
            color: constants.blue,
          ),
          title: TextStyle(
            color: constants.yellow,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(display1: TextStyle(color: constants.yellow)),
          color: constants.blue,
          actionsIconTheme: IconThemeData(
            color: constants.yellow,
          ),
        ),
        textTheme: TextTheme(
          display1: TextStyle(color: constants.blue),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double bmi = 0.0;
  double _opacity = 0.0;

  bool showBMI = false;

  int heightFeet = 5;
  int heightInches = 9;
  int totalHeight = 120;
  int weight = 180;

  void calculate() {
    setState(() {
      totalHeight = heightInches + (heightFeet * 12);
      bmi = 703 * (weight / pow(totalHeight, 2));
      showBMI = true;
    });
  }

  String classification() {
    var result;
    if (bmi < 18.5) result = "Underweight";
    if (bmi > 18.5 && bmi < 25) result = "Normal";
    if (bmi >= 25 && bmi < 30) result = "Overweight";
    if (bmi > 30) result = "Obese";
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => InfoScreen()),
              );
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            showBMI = false;
          });
        },
        child: Stack(
          children: <Widget>[
            AnimatedOpacity(
              opacity: showBMI ? 1.0 : 0.0,
              curve: Curves.ease,
              duration: Duration(milliseconds: 500),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 70.0,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: constants.blue,
                            ),
                            child: Center(
                              child: Text(
                                "BMI SCORE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(42.0),
                            child: FittedBox(
                              child: Text(bmi.toStringAsFixed(1)),
                            ),
                          ),
                          Center(
                            child: Text(
                              classification(),
                              style: TextStyle(
                                fontSize: 23.0,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                showBMI = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: showBMI ? 0.0 : 1.0,
              duration: Duration(milliseconds: 450),
              curve: Curves.ease,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "We need your height and weight in order to determine your BMI score.",
                      style: TextStyle(
                          fontSize: 18.0, height: 1.2, color: constants.blue),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "WEIGHT",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: constants.blue,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (data) {
                        setState(() {
                          weight = int.parse(data);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "in pounds (lb)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      "HEIGHT",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: constants.blue,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (data) {
                              setState(() {
                                heightFeet = int.parse(data);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "ft",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Flexible(
                          flex: 2,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (data) {
                              setState(() {
                                heightInches = int.parse(data);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "in",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36.0),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: (!showBMI)
                          ? FlatButton(
                              child: Text(
                                "CALCULATE MY BMI",
                                style: TextStyle(fontSize: 24.0),
                              ),
                              onPressed: () {
                                calculate();
                              },
                              color: constants.yellow,
                              textColor: Colors.white,
                              splashColor: constants.blue,
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
