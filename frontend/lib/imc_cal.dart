import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/services/api.dart';

class imc_cal extends StatefulWidget {
  imc_calState createState() {
    return imc_calState();
  }
}

class imc_calState extends State<imc_cal> {
  var nomController = TextEditingController();
  var userController = TextEditingController();
  var passController = TextEditingController();

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
              padding: EdgeInsets.only(left: 100, top: 50),
              child: Text(
                "CREAR USUARIO",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
                  Container(
                    margin: EdgeInsets.only(left: 70, right: 70),
                    child: TextField(
                      controller: nomController,
                      decoration: InputDecoration(
                        hintText: "Entre el nombre",
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 70, right: 70),
                    child: TextField(
                      controller: userController,
                      decoration: InputDecoration(
                        hintText: "Usuario",
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 70, right: 70),
                    child: TextField(
                      controller: passController,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(top: 20)),
                  ElevatedButton(
                    onPressed: () {
                      var data = {
                        "nombre": nomController.text,
                        "user": userController.text,
                        "pass": passController.text,
                      };
                      Api.adduser(data);
                    },
                    child: Text("Guardar"),
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
