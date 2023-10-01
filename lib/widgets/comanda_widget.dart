import 'package:arcade/pages/comandas/comanda_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../entities/comanda.dart';
import '../providers/provider.dart';

class ComandaWidget extends StatefulWidget {
  final Comanda comanda;

  const ComandaWidget({super.key, required this.comanda});

  @override
  State<ComandaWidget> createState() => _ComandaWidgetState();
}

class _ComandaWidgetState extends State<ComandaWidget> {

  set comanda(comanda) {}

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = widget.comanda.isOpen ? Colors.transparent : Colors.green;
    Color borderColor = widget.comanda.isOpen ? Colors.white : Colors.black;
    Color fontColor = widget.comanda.isOpen ? Colors.white : Colors.black;

    final provider = Provider.of<AppProvider>(context, listen: false);

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(25.0),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.comanda.name,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: fontColor,
                    fontWeight: FontWeight.bold)),
            Text(widget.comanda.externalId.toString(),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.18,
                    color: fontColor,
                    fontWeight: FontWeight.bold)),
            Text(
                widget.comanda.isOpen
                    ? "Devido: ${widget.comanda.totalFormatado}"
                    : "Pago: ${widget.comanda.paidFormatado}",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  color: fontColor,
                )),
          ],
        ),
      ),
      onTap: () async {
        HapticFeedback.heavyImpact();
        provider.setCurrentComanda(widget.comanda);

        final newComanda = await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  ComandaDetalhes(comanda: provider.getCurrentComanda())
          ),
        );
        setState(() {
          comanda = newComanda;
        });/*

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComandaDetalhes(comanda: widget.comanda),
          ),
        );*/
      },
    );
  }
}
