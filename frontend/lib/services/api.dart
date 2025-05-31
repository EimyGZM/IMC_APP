import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://192.168.1.10/api/";

  static adduser(Map pdata) async {
    print(pdata);
    var url = Uri.parse(baseUrl + "add_usuario");
    try {
      final res = await http.post(url, body: pdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("Fallo al guardar la data");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
