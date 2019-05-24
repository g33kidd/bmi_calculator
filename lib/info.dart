import 'package:flutter/material.dart';
import 'constants.dart' as constants;

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("What is BMI?"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Body Mass Index (BMI)",
              style: TextStyle(fontSize: 24.0, color: constants.blue),
            ),
            SizedBox(height: 16.0),
            Text(constants.aboutText, style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 16.0),
            Text(
              "BMI Limitations",
              style: TextStyle(fontSize: 24.0, color: constants.blue),
            ),
            SizedBox(height: 16.0),
            Text(
              constants.aboutLimitationsText,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
