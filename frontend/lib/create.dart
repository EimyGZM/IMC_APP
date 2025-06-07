import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart'; // Ya incluido en material.dart
import 'package:frontend/services/api.dart'; // Asegúrate de que esta ruta sea correcta

class createscreen extends StatefulWidget {
  const createscreen({super.key}); // Mejor práctica añadir Key

  @override
  createscreenState createState() {
    return createscreenState();
  }
}

class createscreenState extends State<createscreen> {
  // Usar _ para indicar que son privados
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isLoading = false; // Estado para el indicador de carga
  String _message = ''; // Mensaje de éxito/error al usuario

  @override
  void dispose() {
    // ¡IMPORTANTE!: Liberar los controladores
    _nomController.dispose();
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _createUser() async {
    // 1. Validar campos básicos en el frontend
    if (_nomController.text.isEmpty ||
        _userController.text.isEmpty ||
        _passController.text.isEmpty) {
      setState(() {
        _message = 'Todos los campos son obligatorios.';
      });
      return;
    }

    setState(() {
      _isLoading = true; // Mostrar indicador de carga
      _message = ''; // Limpiar mensajes previos
    });

    try {
      var userData = {
        "nombre": _nomController.text,
        "user": _userController.text,
        "pass": _passController.text,
      };

      final response = await Api.addUser(userData);

      setState(() {
        _message = response['message'];
        if (response['success']) {
          _nomController.clear();
          _userController.clear();
          _passController.clear();
        }
      });
    } catch (e) {
      setState(() {
        _message = 'Error al conectar con el servidor: $e';
      });
    } finally {
      setState(() {
        _isLoading = false; // Ocultar indicador de carga
      });
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
          // Permite hacer scroll si el teclado cubre los campos
          child: Column(
            children: [
              // Título
              Padding(
                padding: const EdgeInsets.only(top: 80.0, bottom: 20.0),
                child: Text(
                  "CREAR USUARIO",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Contenedor principal del formulario
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withOpacity(0.85),
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
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: "Nombre Completo",
                        hintText: "Ej: Juan Pérez",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _userController,
                      decoration: InputDecoration(
                        labelText: "Nombre de Usuario",
                        hintText: "Ej: juan.p",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.account_circle),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passController,
                      obscureText: true, // Oculta la contraseña
                      decoration: InputDecoration(
                        labelText: "Contraseña",
                        hintText: "Mínimo 6 caracteres",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Botón de Guardar
                    _isLoading
                        ? const CircularProgressIndicator() // Indicador de carga
                        : ElevatedButton(
                            onPressed:
                                _createUser, // Llama a la función asíncrona
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
                              "Crear Cuenta",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),

                    // Mensaje de éxito/error
                    if (_message.isNotEmpty)
                      Text(
                        _message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _message.contains('exitosa')
                              ? Colors.green
                              : Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
