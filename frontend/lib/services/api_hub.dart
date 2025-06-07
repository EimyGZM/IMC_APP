import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String _baseUrl = "http://192.168.1.10:3000/api";

  static Future<Map<String, dynamic>> addUser(
    Map<String, dynamic> userData,
  ) async {
    final url = Uri.parse('$_baseUrl/users');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        debugPrint('Usuario creado exitosamente: ${responseBody['message']}');
        return {'success': true, 'message': responseBody['message']};
      } else if (response.statusCode == 400 || response.statusCode == 409) {
        debugPrint('Error del cliente: ${responseBody['message']}');
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Error en la solicitud.',
        };
      } else {
        debugPrint(
          'Fallo al guardar la data. Código de estado: ${response.statusCode}',
        );
        return {
          'success': false,
          'message':
              responseBody['message'] ?? 'Error desconocido del servidor.',
        };
      }
    } catch (e) {
      debugPrint('Error al conectar o procesar la respuesta: $e');
      return {'success': false, 'message': 'Error de conexión: $e'};
    }
  }

  static Future<List<User>?> get_usuario() async {
    List<User> userList = [];
    final url = Uri.parse('$_baseUrl/get_usuario');

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        debugPrint('Datos recibidos de get_usuario: $data'); // Usar debugPrint

        if (data is Map && data.containsKey('user') && data['user'] is List) {
          data['user'].forEach((value) {
            userList.add(
              User(
                nombre: value['nom'],
                usuario: value['user'],
                pass: value['pass'],
              ),
            );
          });
        } else {
          debugPrint(
            'La estructura de la respuesta no contiene la clave "user" o no es una lista.',
          );
          return null;
        }
        return userList;
      } else {
        debugPrint(
          'Fallo al obtener la data. Código de estado: ${res.statusCode}',
        );
        return null;
      }
    } catch (e) {
      debugPrint('Error al obtener usuarios: $e');
      return null;
    }
  }
}
