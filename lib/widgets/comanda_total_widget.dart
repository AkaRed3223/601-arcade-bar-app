import 'package:flutter/material.dart';

import '../entities/comanda.dart';

class TotalComandaWidget extends StatefulWidget {
  final Comanda comanda;

  const TotalComandaWidget({super.key, required this.comanda});

  @override
  State<TotalComandaWidget> createState() => _TotalComandaWidgetState();
}

class _TotalComandaWidgetState extends State<TotalComandaWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.comanda.isOpen)
          Expanded(
            child: _buildTotalWidget(
              context,
              'Total devido',
              widget.comanda.totalFormatado,
            ),
          ),
        if (widget.comanda.isOpen)
          Expanded(
            child: _buildTotalWidget(
              context,
              'Total pago',
              widget.comanda.paidFormatado,
            ),
          ),
        if (!widget.comanda.isOpen)
          Expanded(
            child: _buildTotalWidget(
              context,
              'Total pago',
              widget.comanda.paidFormatado,
            ),
          ),
      ],
    );
  }

  Column _buildTotalWidget(BuildContext context, String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          color: Colors.green,
          thickness: 5,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.07,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
