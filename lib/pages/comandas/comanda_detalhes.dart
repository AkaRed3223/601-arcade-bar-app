import 'dart:convert';

import 'package:arcade/pages/comandas/comanda_fechar.dart';
import 'package:arcade/pages/pedidos/pedido_inserir.dart';
import 'package:arcade/pages/pedidos/pedido_remover.dart';
import 'package:arcade/widgets/pedido_widget.dart';
import 'package:arcade/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../entities/comanda.dart';
import '../../entities/payment.dart';
import '../../providers/provider.dart';
import '../../widgets/comanda_total_widget.dart';

class ComandaDetalhes extends StatefulWidget {
  final Comanda comanda;

  const ComandaDetalhes({super.key, required this.comanda});

  @override
  State<ComandaDetalhes> createState() => _ComandaDetalhesState();
}

class _ComandaDetalhesState extends State<ComandaDetalhes> {
  final TextEditingController valueController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  set comanda(comanda) {}
  bool showSuccess = false;
  bool showError = false;
  int? selectedComandaId;

  Future<void> _pagarComanda(Comanda comanda) async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    // const String baseUrl = 'http://localhost:8080';
    // const String baseUrl = 'http://172.31.48.1:8080';
    const String baseUrl = 'http://3.137.160.128:8080';

    final url = Uri.parse('$baseUrl/tabs/$selectedComandaId/pay');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'value': valueController.text,
      'name': nameController.text,
      'details': detailsController.text
    };

    final response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final payment = Payment.fromJson(jsonData);

      final provider = Provider.of<AppProvider>(context, listen: false);
      provider.addPaymentToComanda(payment);
      provider.setCurrentComanda(comanda);

      setState(() {
        showSuccess = true;
        provider.addPaymentToComanda(payment);
        provider.setCurrentComanda(comanda);
      });
    } else {
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final currentComanda = provider.getCurrentComanda();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          '${currentComanda.name} - ${currentComanda.phone}',
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop(provider.comandas);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.monetization_on),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        color: Colors.grey[800],
                      ),
                      child: Column(
                        children: [
                          TextInputWidget(
                              controller: valueController,
                              label: 'Valor do pagamento'),
                          TextInputWidget(
                              controller: nameController,
                              label: 'Nome do pagante'),
                          TextInputWidget(
                              controller: detailsController, label: 'Detalhes'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton.extended(
                              foregroundColor: Colors.white,
                              heroTag: 'pagar parcial',
                              onPressed: () async {
                                selectedComandaId = currentComanda.id;
                                HapticFeedback.heavyImpact();
                                await _pagarComanda(currentComanda);
                                if (showSuccess) {
                                  setState(() {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Center(
                                          child: Text(
                                            'PAGAMENTO RECEBIDO!',
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
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Center(
                                          child: Text(
                                            'PROBLEMA AO INSERIR PAGAMENTO!',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      duration: Duration(seconds: 1),
                                    ));
                                  });
                                }
                                Navigator.of(context).pop(ComandaDetalhes(comanda: currentComanda));
                              },
                              backgroundColor: Colors.green,
                              icon: const Icon(Icons.paid),
                              label: const Text('PAGAR'),
                            ),
                          ),

                        ],
                      ),
                    );
                  });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: currentComanda.products.length,
              itemBuilder: (context, index) {
                return PedidoWidget(produto: currentComanda.products[index]);
              },
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: TotalComandaWidget(comanda: currentComanda),
            ),
          ),
          const SizedBox(width: 5),
          Visibility(
            visible: currentComanda.isOpen && !currentComanda.isDeleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: FloatingActionButton.extended(
                      heroTag: 'remove pedido',
                      onPressed: () async {
                        HapticFeedback.heavyImpact();
                        final newComanda = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  PedidoRemover(comanda: currentComanda)),
                        );
                        setState(() {
                          comanda = newComanda;
                        });
                      },
                      backgroundColor: Colors.grey[800],
                      icon: const Icon(Icons.remove),
                      label: const Text('Pedido'),
                    )),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: FloatingActionButton.extended(
                    heroTag: 'fechar comanda',
                    onPressed: () async {
                      HapticFeedback.heavyImpact();

                      final newComanda = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ComandaFechar(comanda: currentComanda)),
                      );
                      setState(() {
                        comanda = newComanda;
                      });
                    },
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.monetization_on),
                    label: const Text('FECHAR'),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: FloatingActionButton.extended(
                    heroTag: 'add pedido',
                    onPressed: () async {
                      HapticFeedback.heavyImpact();
                      final newComanda = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                PedidoInserir(comanda: currentComanda)),
                      );
                      setState(() {
                        comanda = newComanda;
                      });
                    },
                    backgroundColor: Colors.grey[800],
                    icon: const Icon(Icons.add),
                    label: const Text('Pedido'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
