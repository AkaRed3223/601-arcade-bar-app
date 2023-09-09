import 'dart:convert';
import 'package:http/http.dart' as http;

class Categoria {
  final int id;
  final String name;
  final int position;

  Categoria({
    required this.id,
    required this.name,
    required this.position,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      name: json['name'],
      position: json['position'],
    );
  }

  static List<Categoria> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => Categoria.fromJson(item)).toList();
  }
}

class CategoriasService {
  Future<List<Categoria>> fetchCategorias() async {
    final response = await http.get(
      Uri.parse('https://arcade-bar-backend.rj.r.appspot.com/categories'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final List<Categoria> categoriasList = Categoria.listFromJson(jsonData);
      return categoriasList;
    } else {
      throw Exception('API call failed with status code: ${response.statusCode}');
    }
  }
}