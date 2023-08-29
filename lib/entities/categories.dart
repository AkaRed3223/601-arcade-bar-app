import 'dart:convert';
import 'package:http/http.dart' as http;

class Categories {
  final int id;
  final String name;
  final int position;

  Categories({
    required this.id,
    required this.name,
    required this.position,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'],
      position: json['position'],
    );
  }

  static List<Categories> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => Categories.fromJson(item)).toList();
  }
}

class CategoriesService {
  Future<List<Categories>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('http://192.168.240.1:8080/categories'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final List<Categories> categoriasList = Categories.listFromJson(jsonData);
      return categoriasList;
    } else {
      throw Exception('API call failed with status code: ${response.statusCode}');
    }
  }
}