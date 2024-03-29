import 'dart:convert';

import 'package:arcade/pages/comandas/comanda_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../entities/categoria.dart';
import '../../entities/comanda.dart';
import '../../entities/produto.dart';
import '../../providers/provider.dart';

class PedidoInserir extends StatefulWidget {
  late final Comanda comanda;

  PedidoInserir({
    Key? key,
    required this.comanda,
  }) : super(key: key);

  @override
  State<PedidoInserir> createState() => _PedidoInserirState();
}

class _PedidoInserirState extends State<PedidoInserir> {
  List<Item> _data = [];
  Produto? selectedProduct;
  bool showSuccess = false;
  bool showError = false;

  final ScrollController _scrollController = ScrollController();

  Future<void> _atualizarComanda(int comandaId, int productId) async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    final url = Uri.parse('${dotenv.get('BASE_URL')}/tabs/$comandaId/insert');
    final headers = {'Content-Type': 'application/json'};
    final queryParams = {'productId': productId.toString()};

    final response = await http.put(url.replace(queryParameters: queryParams),
        headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        showSuccess = true;
      });

      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final newComanda = Comanda.fromJson(jsonData);

      final provider = Provider.of<AppProvider>(context, listen: false);
      provider.setCurrentComanda(newComanda);

    } else {
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final produtos = provider.produtos;
    final categorias = provider.categorias;

    _data = categorias.map((categoria) {
      return Item(
        categoria: categoria,
        produtos: produtos
            .where((produto) => produto.category.id == categoria.id)
            .toList(),
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Inserir Pedido'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop(ComandaDetalhes(comanda: widget.comanda));
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ExpansionPanelList.radio(
              dividerColor: Colors.green,
              expandedHeaderPadding: const EdgeInsets.all(0),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _data[index].isExpanded = !isExpanded;
                });
              },
              expandIconColor: Colors.white,
              children: _data.map<ExpansionPanelRadio>((Item item) {
                return ExpansionPanelRadio(
                  value: item.categoria,
                  backgroundColor: Colors.grey[900],
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        item.categoria.name,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  body: Column(
                    children: item.produtos.map((produto) => ListTile(
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
                        HapticFeedback.heavyImpact();
                        setState(() {
                          selectedProduct = produto;
                        });
                      },
                    )).toList(),
                  ),
                  //isExpanded: item.isExpanded,
                );
              }).toList(),
            ),
            /*for (Categoria categoria in categorias)
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
                  const Divider(color: Colors.white, thickness: 0),
                  Column(
                    children: [
                      for (Produto produto in produtos)
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
                              HapticFeedback.heavyImpact();
                              setState(() {
                                selectedProduct = produto;
                              });
                            },
                          ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 80),*/
          ],
        ),
      ),
      bottomSheet: selectedProduct != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.greenAccent,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Produto selecionado:\n${selectedProduct!.name}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          HapticFeedback.heavyImpact();
          final selectedProduct = this.selectedProduct;
          if (selectedProduct != null) {
            widget.comanda.products.add(selectedProduct);
            await _atualizarComanda(widget.comanda.id, selectedProduct.id);
          }
          if (showSuccess) {
            setState(() {
              this.selectedProduct = null;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Center(
                    child: Text(
                  'PEDIDO RECEBIDO!',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
                duration: Duration(seconds: 1),
              ));
            });
          }
          if (showError) {
            setState(() {
              this.selectedProduct = null;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Center(
                    child: Text(
                      'PROBLEMA AO INSERIR PEDIDO!',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                duration: Duration(seconds: 1),
              ));
            });
          }
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.done),
      ),
    );
  }
}

class Item {
  Item({
    required this.categoria,
    required this.produtos,
    this.isExpanded = false,
  });

  Categoria categoria;
  List<Produto> produtos;
  bool isExpanded;
}
