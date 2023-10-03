import 'dart:convert';

import 'package:arcade/pages/comandas/comanda_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../entities/comanda.dart';
import '../../entities/produto.dart';
import '../../providers/provider.dart';

class PedidoRemover extends StatefulWidget {
  final Comanda comanda;

  const PedidoRemover({super.key, required this.comanda});

  @override
  State<PedidoRemover> createState() => _PedidoRemoverState();
}

class _PedidoRemoverState extends State<PedidoRemover> {
  int? selectedProdutoId;
  bool showSuccess = false;
  bool showError = false;

  Future<void> _atualizarComanda() async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    // const String baseUrl = 'http://localhost:8080';
    // const String baseUrl = 'http://172.31.48.1:8080';
    const String baseUrl = 'http://3.137.160.128:8080';

    if (selectedProdutoId != null) {
      final url = Uri.parse('$baseUrl/tabs/${widget.comanda.id}/remove');
      final headers = {'Content-Type': 'application/json'};
      final queryParams = {'productId': selectedProdutoId.toString()};

      final response = await http.put(url.replace(queryParameters: queryParams),
          headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          showSuccess = true;
          selectedProdutoId = null;
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
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AppProvider>(context, listen: false);
    final currentComanda = provider.getCurrentComanda();

    List<Produto> uniqueProducts = [];
    Set<int> uniqueIds = <int>{};

    for (final produto in currentComanda.products) {
      if (!uniqueIds.contains(produto.id)) {
        uniqueProducts.add(produto);
        uniqueIds.add(produto.id);
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Remover Pedido'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            HapticFeedback.mediumImpact();
            /*Navigator.pop(context,
              MaterialPageRoute(
                builder: (context) => ComandaDetalhes(comanda: provider.getCurrentComanda()),
              ),
            );*/
            Navigator.of(context).pop(ComandaDetalhes(comanda: provider.getCurrentComanda()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonFormField<int>(
                      items: uniqueProducts.map((produto) {
                        return DropdownMenuItem<int>(
                          value: produto.id,
                          child: Text(
                              '${produto.name} (${produto.precoFormatado})'),
                        );
                      }).toList(),
                      itemHeight: 60,
                      dropdownColor: Colors.grey[800],
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      value: selectedProdutoId,
                      onChanged: (value) {
                        setState(() {
                          selectedProdutoId = value;
                          showSuccess = false;
                        });
                      },
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Selecionar Produto',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (selectedProdutoId != null)
                      Card(
                        color: Colors.grey[800],
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Produto: ${currentComanda.products.firstWhere((produto) => produto.id == selectedProdutoId!).name}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Preço: ${currentComanda.products.firstWhere((produto) => produto.id == selectedProdutoId!).precoFormatado}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white70,
                                    foregroundColor: Colors.black,
                                    minimumSize: const Size(220, 90)),
                                onPressed: () {
                                  HapticFeedback.heavyImpact();
                                  _atualizarComanda();
                                },
                                child: const Text(
                                  'Excluir Pedido',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (showSuccess)
                            const Column(
                              children: [
                                SizedBox(height: 20),
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 100,
                                  color: Colors.green,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Produto excluído com sucesso!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          if (showError)
                            const Column(
                              children: [
                                SizedBox(height: 20),
                                Icon(
                                  Icons.error_outline,
                                  size: 100,
                                  color: Colors.red,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Erro ao excluir Produto!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
