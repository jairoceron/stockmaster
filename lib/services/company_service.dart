import 'dart:convert';
import 'package:http/http.dart' as http;

class CompanyService {
  Future<int?> saveCompany({
    required String name,
    required String email,
    required String direccion,
    required String pais,
    required String ciudad,
    required String celular,
  }) async {
    final companyJson = {
      "name": name,
      "email": email,
      "direccion": direccion,
      "pais": pais,
      "ciudad": ciudad,
      "celular": celular,
    };

    final url = Uri.parse(
        "https://hsl36h9dj0.execute-api.us-east-2.amazonaws.com/dev/queryMiel06");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(companyJson),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return responseJson["business"]["id"];
    } else {
      throw Exception("Error al guardar empresa: ${response.body}");
    }
  }
}
