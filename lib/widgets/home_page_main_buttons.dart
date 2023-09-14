import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeButton extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HomeButton({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
      onPressed: () {
        HapticFeedback.heavyImpact();
        Navigator.pushNamed(context, _findRouteByTitle(title));
      },
      child: Container(
        padding: const EdgeInsets.all(50.0),
        color: Colors.grey,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
      ),
    );
  }

  _findRouteByTitle(String title) {
    Map<String, String> routeMap = {
      'Comandas': 'menu_comandas',
      'Ver Comandas': 'menu_comandas/comandas/ver',
      'Abrir Comanda': 'menu_comandas/comandas/abrir',
      'Fechar Comanda': 'menu_comandas/comandas/fechar',
      'Excluir Comanda': 'menu_comandas/comandas/excluir',
      'Cardápio': 'cardapio',
    };
    return routeMap[title] ?? '/';
  }
}
