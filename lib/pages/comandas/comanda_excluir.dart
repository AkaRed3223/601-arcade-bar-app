import 'package:arcade/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../entities/comanda.dart';

class ComandaExcluir extends StatefulWidget {
  final List<Comanda> comandas;

  const ComandaExcluir({super.key, required this.comandas});

  @override
  State<ComandaExcluir> createState() => _ComandaExcluirState();
}

class _ComandaExcluirState extends State<ComandaExcluir> {
  int? selectedComandaId;
  bool showSuccess = false;
  bool showError = false;

  Future<void> _excluirComanda() async {

    setState(() {
      showSuccess = false;
      showError = false;
    });

    if (selectedComandaId != null) {
      final url =
          Uri.parse('http://192.168.240.1:8080/tabs/$selectedComandaId');

      final response = await http.delete(url);

      if (response.statusCode == 204) {
        setState(() {
          showSuccess = true;
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
      appBar: const CustomAppBar(title: 'Excluir Comanda'),
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
                      value: selectedComandaId,
                      onChanged: (value) {
                        setState(() {
                          selectedComandaId = value;
                          showSuccess = false;
                        });
                      },
                      items: widget.comandas
                          .where((comanda) => comanda.products.isEmpty)
                          .map((comanda) {
                        return DropdownMenuItem<int>(
                          value: comanda.id,
                          child: Text('${comanda.name} (${comanda.externalId})'),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Selecionar Comanda',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (selectedComandaId != null)
                      ComandaDetailsCard(
                        comanda: widget.comandas.firstWhere(
                            (comanda) => comanda.id == selectedComandaId!),
                        onDelete: _excluirComanda,
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
                              'Atenção! Esta lista contém apenas as comandas vazias!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.06,
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
                                Text(
                                    'Comanda excluída com sucesso!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )
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
                                    'Erro ao excluir comanda!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )
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

class ComandaDetailsCard extends StatelessWidget {
  final Comanda comanda;
  final VoidCallback onDelete;
  final bool showSuccess;

  const ComandaDetailsCard(
      {super.key,
      required this.comanda,
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
              'Número da Comanda: ${comanda.externalId}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Nome: ${comanda.name}',
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
              onPressed: onDelete,
              child: const Text(
                'Excluir Comanda',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
