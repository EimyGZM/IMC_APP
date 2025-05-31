import 'package:flutter/material.dart';
import 'package:frontend/HomePage.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "GESTION IMC", home: HomePage());
  }
}
