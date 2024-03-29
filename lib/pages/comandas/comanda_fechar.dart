import 'package:arcade/pages/comandas/comanda_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../entities/comanda.dart';
import '../../entities/payment.dart';
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

    final url = Uri.parse('${dotenv.get('BASE_URL')}/tabs/$selectedComandaId/checkout');
    final headers = {'Content-Type': 'application/json'};
    //final body = {'externalId': idController.text, 'name': nameController.text};

    final response = await http.put(url, headers: headers);

    if (response.statusCode == 200) {
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
      appBar: CustomAppBar(
        title: 'Fechar Comanda',
        backDestination: ComandaDetalhes(comanda: widget.comanda),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.transparent,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(widget.comanda.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 12),
                Text("${widget.comanda.externalId}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const Divider(
                  color: Colors.green,
                  thickness: 2,
                ),
                for (Payment payment in widget.comanda.payments)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('${payment.name} - ${Comanda.formatCurrency(payment.value)}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                const Divider(
                  color: Colors.green,
                  thickness: 2,
                ),
                Text("Total devido: ${widget.comanda.totalFormatado}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 12,
                ),
                for (Produto produto in widget.comanda.products)
                  Text("${produto.name} - ${produto.precoFormatado}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.white)),
                if (showSuccess)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Icon(
                          Icons.check_circle_outline,
                          size: 100,
                          color: Colors.green,
                        ),
                        SizedBox(height: 20),
                        Text('Comanda encerrada!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                const SizedBox(height: 12,),
                if (showError)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Icon(
                          Icons.error_outline,
                          size: 100,
                          color: Colors.red,
                        ),
                        SizedBox(height: 20),
                        Text('Erro ao encerrar comanda!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                color: Colors.greenAccent,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'FECHAR COMANDA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        onLongPressStart: (context) {
          HapticFeedback.selectionClick();
        },
        onLongPress: () {
          _showConfirmationDialog();
        },
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Fechar comanda?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                HapticFeedback.heavyImpact();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                HapticFeedback.heavyImpact();
                Navigator.of(context).pop();
                _fecharComanda();
              },
            ),
          ],
        );
      },
    );
  }
}
