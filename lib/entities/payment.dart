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