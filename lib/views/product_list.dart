import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:apptienda/controllers/products_controller.dart';
import 'package:get/get.dart';
import 'package:apptienda/views/item_product.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController productsController = Get.put(ProductsController());

    return FutureBuilder<void>(
      future: productsController.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Contenido original del FutureBuilder
          return Center(
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
                        'Lista de Productos',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.green,
                          fontFamily: 'TitilliumWeb',
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/cart-shopping-solid.svg',
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
                    itemCount: productsController.products.length,
                    itemBuilder: (context, index) {
                      final producto = productsController.products[index];
                      return ItemProduct(producto);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
