import 'package:arcade/entities/guest_tab.dart';
import 'package:flutter/material.dart';

import '../entities/product.dart';
import '../widgets/custom_app_bar_widget.dart';
import '../widgets/guest_tab_widget.dart';

class Comandas extends StatelessWidget {
  const Comandas({super.key});

  @override
  Widget build(BuildContext context) {
    List<GuestTab> tabs = [
      GuestTab(id: 26, guestName: 'César', orderedProducts: [
        Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
        Product(name: "Original", imageUrl: '', price: 12.90),
        Product(name: "Coca", imageUrl: '', price: 8.90),
      ]),
      GuestTab(id: 27, guestName: 'Gabs', orderedProducts: [
        Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
        Product(name: "Original", imageUrl: '', price: 11.90)
      ]),
      GuestTab(id: 28, guestName: 'Elias', orderedProducts: [
        Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
        Product(name: "Original", imageUrl: '', price: 10.90)
      ]),
      GuestTab(id: 29, guestName: 'Saulo', orderedProducts: [
        Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
        Product(name: "Original", imageUrl: '', price: 10.90)
      ]),
      GuestTab(id: 30, guestName: 'Lucas', orderedProducts: [
        Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
        Product(name: "Original", imageUrl: '', price: 10.90)
      ]),
      GuestTab(id: 31, guestName: 'Léo', orderedProducts: [
        Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
        Product(name: "Original", imageUrl: '', price: 10.90)
      ]),
      GuestTab(id: 32, guestName: 'Pagan', orderedProducts: [
        Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
        Product(name: "Original", imageUrl: '', price: 10.90)
      ]),
      GuestTab(id: 33, guestName: 'Takatu', orderedProducts: [
        Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
        Product(name: "Original", imageUrl: '', price: 10.90)
      ]),
      GuestTab(id: 34, guestName: 'Ichinose', orderedProducts: [
        Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
        Product(name: "Original", imageUrl: '', price: 10.90)
      ]),
      GuestTab(id: 35, guestName: 'Ueda', orderedProducts: [
        Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
        Product(name: "Original", imageUrl: '', price: 10.90)
      ]),

    ];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Comandas'),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0
          ),
          itemCount: tabs.length,
          itemBuilder: (BuildContext context, int index) {
            return GuestTabWidget(guestTab: tabs[index]);
          }),
    );
  }
}
