import 'package:flutter/material.dart';

import '../../entities/categoria.dart';
import '../../entities/comanda.dart';
import '../../entities/produto.dart';
import '../../widgets/custom_app_bar_widget.dart';
import 'package:http/http.dart' as http;

class PedidoInserir extends StatefulWidget {
  final Comanda comanda;
  final List<Produto> cardapio;

  const PedidoInserir({
    Key? key,
    required this.comanda,
    required this.cardapio,
  }) : super(key: key);

  @override
  State<PedidoInserir> createState() => _PedidoInserirState();
}

class _PedidoInserirState extends State<PedidoInserir> {
  Produto? selectedProduct;
  //final ScrollController _scrollController = ScrollController();

  List<Categoria> mockCategorias = [
    Categoria(id: 1, name: "Lanches", position: 0),
    Categoria(id: 2, name: "Bebidas", position: 1),
    Categoria(id: 3, name: "Porções", position: 2),
  ];

  /*List<Produto> mockCardapio = [
    Produto(
        id: 1,
        name: "X-Burger",
        price: 24.90,
        category: Categoria(id: 0, name: "Lanches", position: 0)
    ),
    Produto(
        id: 2,
        name: "X-Bacon",
        price: 26.90,
        category: Categoria(id: 0, name: "Lanches", position: 0)
    ),
    Produto(
        id: 3,
        name: "X-Pagan",
        price: 34.90,
        category: Categoria(id: 0, name: "Lanches", position: 0)
    ),
    Produto(
        id: 4,
        name: "Original",
        price: 12.90,
        category: Categoria(id: 1, name: "Bebidas", position: 1)
    ),
    Produto(
        id: 5,
        name: "Coca-cola",
        price: 6.90,
        category: Categoria(id: 1, name: "Bebidas", position: 1)
    ),
    Produto(
        id: 6,
        name: "Batata frita",
        price: 14.90,
        category: Categoria(id: 2, name: "Porções", position: 2)
    ),
  ];*/

  Future<void> _atualizarComanda(int comandaExternalId, int productId) async {
    /*setState(() {
      showSuccess = false;
      showError = false;
    });*/

    final url = Uri.parse('http://192.168.240.1:8080/tabs/$comandaExternalId');
    final headers = {'Content-Type': 'application/json'};
    final queryParams = {'productId': productId.toString()};
    //final body = {'externalId': idController.text, 'name': nameController.text};

    final response = await http.put(url.replace(queryParameters: queryParams),
        headers: headers);

    if (response.statusCode == 200) {
      print("sucesso");

      /*setState(() {
        showSuccess = true;
      });*/
    } else {
      print("falha");
      /*setState(() {
        showError = true;
      });*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Novo Pedido'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (Categoria categoria in mockCategorias)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.green,
                    thickness: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categoria.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.green,
                  ),
                  Column(
                    children: [
                      for (Produto produto in widget.cardapio)
                        if (produto.category.id == categoria.id)
                          ListTile(
                            title: Text(
                              '${produto.name} - ${produto.precoFormatado}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selectedProduct = produto;
                              });
                            },
                          ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 20),
            selectedProduct != null
                ? Text(
                    'Produto selecionado:\n${selectedProduct!.name}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final selectedProduct = this.selectedProduct;
          if (selectedProduct != null) {
            widget.comanda.products.add(selectedProduct);
            _atualizarComanda(widget.comanda.externalId, selectedProduct.id);
          }
          //Retornar para a página anterior renderizando com o novo produto
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.done),
      ),
    );
  }
}
