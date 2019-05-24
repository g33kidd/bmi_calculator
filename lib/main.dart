import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(App());

const Color blue = Color(0xFF1A4B76);
const Color yellow = Color(0xFFFFBD2A);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BMI Calculator",
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          display1: TextStyle(
            color: blue,
          ),
          title: TextStyle(
            color: yellow,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(display1: TextStyle(color: yellow)),
          color: blue,
          actionsIconTheme: IconThemeData(
            color: yellow,
          ),
        ),
        textTheme: TextTheme(
          display1: TextStyle(color: blue),
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
              print("Information about BMI.");
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
                      child: FittedBox(
                        child: Text(bmi.toString()),
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
                      style:
                          TextStyle(fontSize: 18.0, height: 1.2, color: blue),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "WEIGHT",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: blue,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
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
                        color: blue,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: TextField(
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
                              color: yellow,
                              textColor: Colors.white,
                              splashColor: blue,
                            )
                          : Offstage(),
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
