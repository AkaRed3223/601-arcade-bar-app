import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/home_page_main_buttons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('601 Arcade Bar - Home Page'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 2,
      ),
      body: ListView(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: HomeButton(title: 'Comandas'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: HomeButton(title: 'Cardápio'),
          ),
        ],
      ),
    );
  }
}
