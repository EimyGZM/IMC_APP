import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/create.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
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

            Container(
              margin: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white54,
                  ),
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => createscreen()));
                    },
                    icon: Icon(Icons.create),
                    label: Text("CREAR"),
                  ),

                  Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.create),
                    label: Text("CALCULAR"),
                  ),

                  Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.create),
                    label: Text("PRINT"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
