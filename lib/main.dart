import 'package:flutter/material.dart';
import 'package:apptienda/views/product_list.dart';
import 'package:apptienda/views/cart_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mi tienda'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'Madimi One',
              color: Colors.white,
            ),
          ),
        ),
        body: const ProductList() ,
		floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la siguiente página al hacer clic en el botón
			Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => const CartProduct()),
			);
        },
		backgroundColor: Colors.red, 
		foregroundColor: Colors.white,
        child: const Icon(Icons.shopping_cart),
      ),
		);
  }
}
