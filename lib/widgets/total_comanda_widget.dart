import 'package:flutter/material.dart';

import '../entities/comanda_dto.dart';

class TotalComandaWidget extends StatelessWidget {
  const TotalComandaWidget({super.key, required this.comanda});

  final Comanda comanda;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Total devido',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.green,
            thickness: 5,
          ),
          Text(
              comanda.totalFormatado,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }
}
