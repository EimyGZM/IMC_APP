import 'package:flutter/material.dart';
//import 'package:frontend/services/api.dart'; // Mantén esta importación si aún la necesitas para otras funciones

class IMC_cal extends StatefulWidget {
  const IMC_cal({super.key}); // Añadir Key para una mejor práctica

  @override
  IMC_calState createState() {
    return IMC_calState();
  }
}

class IMC_calState extends State<IMC_cal> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _imcResultController = TextEditingController();

  String _imcStatus = '';

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    _imcResultController.dispose();
    super.dispose();
  }

  void _calculateIMC() {
    final String pesoString = _pesoController.text;
    final String alturaString = _alturaController.text;

    final double? peso = double.tryParse(pesoString);
    final double? altura = double.tryParse(alturaString);

    if (peso == null || altura == null || altura <= 0) {
      setState(() {
        _imcResultController.text = 'Entrada inválida';
        _imcStatus = 'Introduce valores numéricos válidos y altura mayor a 0.';
      });
      return;
    }

    final double imc = peso / (altura * altura);

    setState(() {
      _imcResultController.text = imc.toStringAsFixed(2);
      _imcStatus = _getIMCStatus(imc); // Obtener el estado del IMC
    });

    // var data = {
    //   "peso": pesoString,
    //   "altura": alturaString,
    //   "imc": _imcResultController.text // Enviar también el IMC calculado
    // };
    // Api.adduser(data); // Asegúrate de que esta función maneje adecuadamente los datos
  }

  String _getIMCStatus(double imc) {
    if (imc < 18.5) {
      return 'Bajo peso';
    } else if (imc >= 18.5 && imc < 24.9) {
      return 'Peso normal';
    } else if (imc >= 25 && imc < 29.9) {
      return 'Sobrepeso';
    } else if (imc >= 30 && imc < 34.9) {
      return 'Obesidad Grado I';
    } else if (imc >= 35 && imc < 39.9) {
      return 'Obesidad Grado II';
    } else {
      return 'Obesidad Grado III (Mórbida)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Título "CALCULAR IMC"
              Padding(
                padding: const EdgeInsets.only(top: 80.0, bottom: 20.0),
                child: Text(
                  "CALCULAR IMC",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 32, // Tamaño de fuente más grande
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withOpacity(0.85), // Un poco transparente
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 30),
                    TextField(
                      controller: _pesoController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ), // Permite decimales
                      decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        hintText: "Ej: 70.5",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.fitness_center),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _alturaController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: "Altura (metros)",
                        hintText: "Ej: 1.75",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.height),
                      ),
                    ),
                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: _calculateIMC,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Calcular IMC",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _imcResultController,
                      readOnly: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      decoration: InputDecoration(
                        labelText: "Tu IMC",
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.deepPurple.withOpacity(0.05),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _imcStatus,
                      style: TextStyle(
                        fontSize: 16,
                        color: _imcStatus.contains('normal')
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
