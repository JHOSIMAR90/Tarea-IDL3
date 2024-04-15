import 'package:flutter/material.dart';
import 'package:apptienda/controllers/products_controller.dart';
import 'package:apptienda/models/product_model.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:apptienda/views/order_product.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController productsController = Get.put(ProductsController());
    return FutureBuilder<List<ProductModel>>(
      future: productsController
          .getCartProducts(), // Obtener los productos del carrito
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<ProductModel> cartProducts = snapshot.data ?? [];
          double total = 0;

          // Calcular el total a pagar
          for (var product in cartProducts) {
            total += product.price * product.cantidad.value;
          }

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                leading: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                title: const Text(
                  'Ansur.pi',
                  style: TextStyle(
                    fontFamily: 'Mi Tienda',
                    color: Colors.white,
                  ),
                ),
              ),
              body: Center(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 30.0,
                        horizontal: 15.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Carrito de Compras',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.green,
                              fontFamily: 'Madimi One',
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/shoping_cart.svg',
                            colorFilter: const ColorFilter.mode(
                              Colors.green,
                              BlendMode.srcIn,
                            ),
                            height: 40,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          final product = cartProducts[index];
                          // Solo mostrar productos con cantidad mayor a 0

                          return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white, // Fondo blanco
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.2), // Color de la sombra
                                    spreadRadius: 5, // Propagación de la sombra
                                    blurRadius: 8, // Desenfoque de la sombra
                                    offset: const Offset(
                                        0, 1), // Desplazamiento de la sombra
                                  ),
                                ], // Bordes redondeados
                              ),
                              child: ListTile(
                                title: Text(product.name),
                                subtitle: Text(
                                  'Precio: \$${product.price} | Cantidad: ${product.cantidad.value}',
                                ),
                              ));
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                           
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 20.0),
                            child: Column(
                              children: [
                                 Container(
                                   color: Colors.blueGrey,
                                   padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 20.0),
                                  child: Text(
                                    'Total a Pagar: ${total.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                
                                ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,            
                                  MaterialPageRoute(builder: (context) => const OrderProduct()),
                                );
                              },
                              child: const Text("Iniciar Orden",style:  TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),),
                            )
                              ],
                            )))
                  ],
                ),
              ));
        }
      },
    );
  }
}
