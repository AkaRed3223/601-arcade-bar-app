import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'comanda.dart';

class Operation {
  final int id;
  final String startDate;
  final String endDate;
  final bool isOpen;
  late final List<Comanda> tabs;

  Operation({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.isOpen,
    required this.tabs
  });

  factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
      id: json['id'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      isOpen: json['isOpen'],
      tabs: Comanda.listFromJson(json['tabs']),
    );
  }

  static List<Operation> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => Operation.fromJson(item)).toList();
  }
}

class OperationsService {
  Future<List<Operation>> fetchOperations() async {
    final response = await http.get(
      Uri.parse('${dotenv.get('BASE_URL')}/operations'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final List<Operation> operationsList = Operation.listFromJson(jsonData);
      return operationsList;
    } else {
      throw Exception('API call failed with status code: ${response.statusCode}');
    }
  }

  Future<Operation> fetchCurrentOperation() async {
    final response = await http.get(
      Uri.parse('${dotenv.get('BASE_URL')}/operations/current'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final Operation operation = Operation.fromJson(jsonData);
      return operation;
    } else {
      throw Exception('API call failed with status code: ${response.statusCode}');
    }
  }

  Future<Operation> initiateOperation() async {
    final response = await http.get(
      Uri.parse('${dotenv.get('BASE_URL')}/operations/initiate'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final Operation operation = Operation.fromJson(jsonData);
      return operation;
    } else {
      throw Exception('API call failed with status code: ${response.statusCode}');
    }
  }

  Future<Operation> closeoutOperation() async {
    final response = await http.get(
      Uri.parse('${dotenv.get('BASE_URL')}/operations/closeout'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final Operation operation = Operation.fromJson(jsonData);
      return operation;
    } else {
      throw Exception('API call failed with status code: ${response.statusCode}');
    }
  }
}