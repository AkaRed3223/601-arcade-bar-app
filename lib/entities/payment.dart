class Payment {
  final int id;
  final int tabId;
  final int tabExternalId;
  final double value;
  final String name;
  final String details;
  final String time;

  Payment({
    required this.id,
    required this.tabId,
    required this.tabExternalId,
    required this.value,
    required this.name,
    required this.details,
    required this.time,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      tabId: json['id'],
      tabExternalId: json['tabExternalId'],
      value: json['value'],
      name: json['name'],
      details: json['details'],
      time: json['time'],
    );
  }

  static List<Payment> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => Payment.fromJson(item)).toList();
  }
}

/*
class PaymentsService {
  Future<List<Payment>> fetchPay() async {

    // const String baseUrl = 'http://localhost:8080';
    const String baseUrl = 'http://172.31.48.1:8080';
    // const String baseUrl = 'http://3.137.160.128:8080';

    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
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
}*/
