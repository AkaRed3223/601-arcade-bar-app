import 'package:arcade/entities/product.dart';

class GuestTab {
  final int id;
  final String guestName;
  final List<Product> orderedProducts;
  final double total;

  GuestTab({
    required this.id,
    required this.guestName,
    required this.orderedProducts,
  }) : total = orderedProducts
            .map((product) => product.price)
            .reduce((sum, price) => sum + price);
}
