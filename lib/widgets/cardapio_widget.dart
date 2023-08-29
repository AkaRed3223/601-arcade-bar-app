// import 'dart:convert';
//
// import 'package:arcade/entities/product.dart';
// import 'package:flutter/material.dart';
//
// import 'package:http/http.dart' as http;
//
// import '../entities/categories.dart';
//
// class CardapioWidget extends StatefulWidget {
//   const CardapioWidget({super.key, required this.produtos, required this.categories});
//
//   final List<Product> produtos;
//   final Future<List<Categories>> categories;
//
//   @override
//   State<CardapioWidget> createState() => _CardapioWidgetState();
// }
//
// class _CardapioWidgetState extends State<CardapioWidget> {
//
//   late Future<List<Categories>> futureCategories;
//   late List<Product> produtos;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Categories>>(
//       future: futureCategories,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator(); // Show loading indicator while fetching data
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Text('No categories available.');
//         } else {
//           return DefaultTabController(
//             length: snapshot.data!.length,
//             child: Scaffold(
//               backgroundColor: Colors.grey[800],
//               appBar: AppBar(
//                 bottom: TabBar(
//                   isScrollable: true,
//                   tabs: snapshot.data!.map((category) {
//                     return Tab(
//                       text: category.name,
//                     );
//                   }).toList(),
//                 ),
//               ),
//               body: TabBarView(
//                 children: snapshot.data!.map((category) {
//                   List<Product> produtosPorCategoria =
//                   produtos.where((produto) => produto.category == category.name).toList();
//
//                   return ListView.builder(
//                     itemCount: produtosPorCategoria.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ListTile(
//                         leading: Image.asset(produtosPorCategoria[index].url),
//                         title: Text(
//                           produtosPorCategoria[index].name,
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontWeight: FontWeight.bold,
//                             fontSize: MediaQuery.of(context).size.width * 0.06,
//                           ),
//                         ),
//                         subtitle: Text(
//                           produtosPorCategoria[index].precoFormatado,
//                           style: TextStyle(
//                             color: Colors.white60,
//                             fontSize: MediaQuery.of(context).size.width * 0.04,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }).toList(),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
//
//
