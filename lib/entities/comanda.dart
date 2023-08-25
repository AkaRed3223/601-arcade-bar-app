import 'package:arcade/entities/produto.dart';

class Comanda {
  final int id;
  final String nome;
  final List<Produto> produtos;
  final double total;

  Comanda({
    required this.id,
    required this.nome,
    required this.produtos,
  }) : total = produtos
            .map((product) => product.preco)
            .reduce((sum, price) => sum + price);
}
