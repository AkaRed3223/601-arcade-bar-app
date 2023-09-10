import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../entities/categoria.dart';
import '../../entities/produto.dart';
import '../../widgets/custom_app_bar_widget.dart';

class CardapioInserirProduto extends StatefulWidget {
  const CardapioInserirProduto({super.key, required this.categorias, required this.produtos});

  final List<Categoria> categorias;
  final List<Produto> produtos;

  @override
  State<CardapioInserirProduto> createState() => _CardapioInserirProdutoState();
}

class _CardapioInserirProdutoState extends State<CardapioInserirProduto> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  int? selectedCategoriaId;
  bool showSuccess = false;
  bool showError = false;

  Future<void> _inserirProduto() async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    final url = Uri.parse('https://arcade-bar-backend-398600.ue.r.appspot.com/products');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'name': nameController.text,
      'price': priceController.text,
      'categoryId': selectedCategoriaId
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 201) {
      setState(() {
        showSuccess = true;
      });
    } else {
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Inserir Produto'),
      body: Center(
        child: GestureDetector(
          onTap: () {
            HapticFeedback.heavyImpact();
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome do Produto',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: priceController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Preço do Produto',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<int>(
                        itemHeight: 60,
                        dropdownColor: Colors.grey[800],
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        value: selectedCategoriaId,
                        onChanged: (value) {
                          setState(() {
                            selectedCategoriaId = value;
                            showSuccess = false;
                          });
                        },
                        items: widget.categorias.map((categoria) {
                          return DropdownMenuItem<int>(
                            value: categoria.id,
                            child: Text(
                                '${categoria.name} (${categoria.position})'),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Selecionar Categoria',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(220, 90)),
                        onPressed: () {
                          HapticFeedback.heavyImpact();
                          _inserirProduto();
                          FocusScope.of(context).unfocus();
                        },
                        child: const Text(
                          'Inserir Produto',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Text('Produto inserido!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
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
                      Text('Erro ao inserir produto!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
