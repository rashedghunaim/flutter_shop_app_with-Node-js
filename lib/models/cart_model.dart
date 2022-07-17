import 'dart:convert';

import 'package:amazon_clone/models/product_model.dart';

class CartModel {
  final ProductModel product;
  final int quantity;
  final id;

  CartModel({
    required this.product,
    required this.quantity,
    required this.id,
  });

  factory CartModel.getJson({required Map<String, dynamic> res}) {
    return CartModel(
      id: res['_id'],
      product: ProductModel.getJson(
        response: jsonDecode(
          jsonEncode(
            res['product'],
          ),
        ),
      ),
      quantity: res['quantity'],
    );
  }

  Map<String, dynamic> sendJson() {
    return {
      'product': product.sendJson(),
      'quantity': quantity,
      '_id': id,
    };
  }
}
