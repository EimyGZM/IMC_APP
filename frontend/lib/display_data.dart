import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:frontend/services/api.dart';

class displayScreen extends StatefulWidget {
  displayScreenState createState() {
    return displayScreenState();
  }
}

class displayScreenState extends State<displayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.greenAccent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
