import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Categoria {
  final int id;
  final String name;
  final int position;
  final String createdAt;
  final String updatedAt;
  final bool isActive;

  Categoria({
    required this.id,
    required this.name,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isActive: json['isActive'],
    );
  }

  static List<Categoria> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => Categoria.fromJson(item)).toList();
  }
}

class CategoriasService {
  Future<List<Categoria>> fetchCategorias() async {
    final response = await http.get(
      Uri.parse('${dotenv.get('BASE_URL')}/categories'),
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