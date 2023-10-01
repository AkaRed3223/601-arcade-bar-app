import 'package:arcade/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../entities/comanda.dart';

class PagarComandaWidget extends StatefulWidget {
  final Comanda comanda;

  const PagarComandaWidget({super.key, required this.comanda});

  @override
  State<PagarComandaWidget> createState() => _PagarComandaWidgetState();
}

class _PagarComandaWidgetState extends State<PagarComandaWidget> {
  final TextEditingController valueController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12)
        ),
        color: Colors.grey[800],
      ),
      child: Column(
        children: [
          TextInputWidget(controller: valueController, label: 'Valor do pagamento'),
          TextInputWidget(controller: nameController, label: 'Nome do pagante'),
          TextInputWidget(controller: detailsController, label: 'Detalhes'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              foregroundColor: Colors.white,
              heroTag: 'pagar parcial',
              onPressed: () {
                HapticFeedback.heavyImpact();
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: builder),
                );*/
              },
              backgroundColor: Colors.green,
              icon: const Icon(Icons.paid),
              label: const Text('text'),
            ),
          )
        ],

      ),
    );
  }
}
