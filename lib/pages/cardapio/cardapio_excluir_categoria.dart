import 'package:arcade/entities/produto.dart';
import 'package:arcade/pages/cardapio/cardapio.dart';
import 'package:arcade/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../entities/categoria.dart';
import '../../providers/provider.dart';

class CardapioExcluirCategoria extends StatefulWidget {
  final List<Categoria> categorias;
  final List<Produto> produtos;

  const CardapioExcluirCategoria({super.key, required this.categorias, required this.produtos});

  @override
  State<CardapioExcluirCategoria> createState() => _CardapioExcluirCategoriaState();
}

class _CardapioExcluirCategoriaState extends State<CardapioExcluirCategoria> {
  int? selectedCategoriaId;
  bool showSuccess = false;
  bool showError = false;

  Future<void> _excluirCategoria() async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    if (selectedCategoriaId != null) {
      // const String baseUrl = 'http://localhost:8080';
      const String baseUrl = 'http://172.31.64.1:8080';
      // const String baseUrl = 'http://3.137.160.128:8080';

      final url = Uri.parse('$baseUrl/categories/$selectedCategoriaId');

      final response = await http.delete(url);

      if (response.statusCode == 204) {
        setState(() {
          showSuccess = true;
        });

        final provider = Provider.of<AppProvider>(context, listen: false);
        provider.removeCategoria(selectedCategoriaId!);

        setState(() {
          selectedCategoriaId = null;
        });

      } else {
        setState(() {
          showError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(
          title: 'Excluir Categoria',
          backDestination: Cardapio(),
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
                      items: widget.categorias
                          .where((c) {
                            return !widget.produtos
                                .any((produto) => produto.category.id == c.id);
                          })
                          .toList()
                          .map((categoria) {
                            return DropdownMenuItem<int>(
                              value: categoria.id,
                              child: Text(
                                  '${categoria.name} (${categoria.position})'),
                            );
                          })
                          .toList(),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Selecionar Categoria',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (selectedCategoriaId != null)
                      CategoriaDetailsCard(
                        categoria: widget.categorias.firstWhere(
                            (comanda) => comanda.id == selectedCategoriaId!),
                        onDelete: _excluirCategoria,
                        showSuccess: showSuccess,
                      ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.warning,
                            color: Colors.redAccent,
                          ),
                          Text(
                              'Atenção! Esta lista contém apenas as categorias vazias!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold)),
                          const Icon(
                            Icons.warning,
                            color: Colors.redAccent,
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
                                Text('Categoria excluída com sucesso!',
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
                                Text('Erro ao excluir Categoria!',
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

class CategoriaDetailsCard extends StatelessWidget {
  final Categoria categoria;
  final VoidCallback onDelete;
  final bool showSuccess;

  const CategoriaDetailsCard(
      {super.key,
      required this.categoria,
      required this.onDelete,
      required this.showSuccess});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Nome da Categoria: ${categoria.name}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Posição: ${categoria.position}',
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
                onDelete();
              },
              child: const Text(
                'Excluir Categoria',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
