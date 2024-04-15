import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apptienda/models/product_model.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final Logger logger = Logger(); // Instancia de Logger

  List<ProductModel> products = [];

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://shop-api-roan.vercel.app/product'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        products =
            responseData.map((data) => ProductModel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  bool incrementQuantity(ProductModel product) {
    // Encuentra el índice del producto en la lista
    int index = products.indexWhere((p) => p.id.startsWith(product.id));
    if (index != -1) {
      // Si se encuentra el producto, incrementa su cantidad
      if (products[index].cantidad < products[index].stock) {
        // Incrementa la cantidad del producto si hay suficiente stock
        products[index].cantidad++;
        logger
            .d('La cantidad del producto ${product.name} ha sido incrementada');
        return true; // Incremento exitoso
      } else {
        // Si la cantidad excede el stock disponible, devuelve false
        logger.d(
            'Error: La cantidad excede el stock disponible para el producto ${product.name}');
        return false; // Incremento fallido
      }
    } else {
      return false;
    }
  }

  void decrementQuantity(ProductModel product) {
    // Encuentra el índice del producto en la lista
    int index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      // Decrementa la cantidad del producto si es mayor que 0
      if (products[index].cantidad > 0) {
        products[index].cantidad--;
        logger.d('La cantidad del producto ${product.name} ha sido decrementada');
      } else {
        // Si la cantidad es 0, muestra un mensaje de advertencia
        logger.d('La cantidad del producto ${product.name} ya es 0, no se puede decrementar más');
      }
    } else {
      // Si no se encuentra el producto, muestra un mensaje de advertencia
      logger.d('No se encontró el producto ${product.id}');
    }
  }

  int getProductQuantity(ProductModel product) {
    int index = products.indexWhere((p) => p.id == product.id);
    return index != -1 ? products[index].cantidad.value : 0;
  }

  // Método para obtener los productos del carrito
  Future<List<ProductModel>> getCartProducts() async {
    // Simulando una consulta a una base de datos o API
    await Future.delayed(const Duration(milliseconds: 100));

    // Filtrar los productos cuya cantidad sea mayor a 0
    List<ProductModel> cartProducts =
        products.where((product) => product.cantidad.value > 0).toList();

    return cartProducts;
  }
}
