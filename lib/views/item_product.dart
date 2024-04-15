import 'package:flutter/material.dart';
import 'package:apptienda/models/product_model.dart';
import 'package:apptienda/controllers/products_controller.dart';
import 'package:get/get.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct(this.producto, {super.key});
  final ProductModel producto;

  @override
  Widget build(BuildContext context) {
    final productsController = Get.find<ProductsController>();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: Image.asset(
                      'assets/images/product.png',
                      width: 50,
                      height: 80,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        producto.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 170,
                        child: Text(
                          producto.description,
                          style: const TextStyle(color: Colors.blueGrey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                producto.price.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              Obx(() {
                if (producto.cantidad.value == 0) {
                  return ElevatedButton(
                    onPressed: () {
                      productsController.incrementQuantity(producto);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      backgroundColor: Colors.green,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    IconButton(
                      icon: const Icon(
                        Icons.remove,
                        size: 15,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        productsController.decrementQuantity(producto);
                      },
                    ),
                    Text(
                      producto.cantidad.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 15,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 15, // Ajusta el tamaño del icono
                        color: Colors.red,
                      ),
                      onPressed: () {
                        bool success =  productsController.incrementQuantity(producto);
                        if (!success) {
                          // Si el incremento no fue exitoso, muestra un mensaje de error
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:const Text('Error'),
                              content:const Text('La cantidad excede el stock disponible para este producto.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child:const Text('Aceptar'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    )
                  ]);
                }
              }),
            ],
          ),
        ],
      ),
    );
  }
}
