import 'package:arcade/entities/categories_enum.dart';
import 'package:arcade/entities/produto_dto.dart';
import 'package:flutter/material.dart';

class CardapioWidget extends StatelessWidget {
  const CardapioWidget({super.key, required this.produtos});

  final List<Produto> produtos;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: Categorias.values.map((categoria) {
        List<Produto> produtosPorCategoria =
        produtos.where((produto) => produto.categoria == categoria).toList();

        return ListView.builder(
          itemCount: produtosPorCategoria.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.asset(produtosPorCategoria[index].url),
              title: Text(
                produtosPorCategoria[index].nome,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
              subtitle: Text(
                produtosPorCategoria[index].precoFormatado,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
