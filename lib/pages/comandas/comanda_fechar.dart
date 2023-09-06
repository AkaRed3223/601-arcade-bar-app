import 'package:flutter/material.dart';

import '../../entities/comanda.dart';
import '../../entities/produto.dart';
import '../../widgets/custom_app_bar_widget.dart';
import 'package:http/http.dart' as http;

class ComandaFechar extends StatefulWidget {
  final Comanda comanda;

  const ComandaFechar({super.key, required this.comanda});

  @override
  State<ComandaFechar> createState() => _ComandaFecharState();
}

class _ComandaFecharState extends State<ComandaFechar> {

  int? selectedComandaId;
  bool showSuccess = false;
  bool showError = false;

  Future<void> _fecharComanda() async {
    selectedComandaId = widget.comanda.id;

    setState(() {
      showSuccess = false;
      showError = false;
    });

    final url = Uri.parse('http://192.168.240.1:8080/tabs/$selectedComandaId/checkout');
    final headers = { 'Content-Type': 'application/json' };
    //final body = {'externalId': idController.text, 'name': nameController.text};

    final response = await http.put(url,headers: headers);

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
      appBar: const CustomAppBar(title: 'Fechar Comanda'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.comanda.name,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            Text("${widget.comanda.externalId}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            Text("Total: ${widget.comanda.totalFormatado}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: Colors.white)),
            for (Produto produto in widget.comanda.products)
              Text("${produto.name} - ${produto.precoFormatado}",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      color: Colors.white)),
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        /*onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            _fecharComanda();
          }
        },*/
        onTap: () {
          _fecharComanda();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                color: Colors.greenAccent,
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'FECHAR COMANDA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
