import 'dart:convert';
import 'rating_model.dart';

class ProductModel {
  final String name;
  final String description;
  final int price;
  final int quantity;
  final List<String> images;
  final String category;
  final String productID;
  final String userID;
  final List<RatingModel> ratings;
  ProductModel({
    required this.category,
    required this.description,
    required this.images,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productID,
    required this.userID,
    required this.ratings,
  });

  factory ProductModel.getJson({required Map<String, dynamic> response}) {
    return ProductModel(
      category: response['category'] ?? '',
      description: response['description'] ?? '',
      images: List<String>.from(response['images']),
      name: response['name'] ?? '',
      price: response['price'] ?? 0.0,
      quantity: response['quantity'] ?? 0,
      productID: response['_id'] ?? '',
      userID: response['userID'] ?? '',
      ratings: List<RatingModel>.from(
        response['ratings'].map(
          (res) => RatingModel.getJson(
            res: jsonDecode(
              jsonEncode(res),
            ),
          ),
        ),
      ),
    );
  }

  factory ProductModel.fromJson(String source) =>
      ProductModel.getJson(response: json.decode(source));

  Map<String, dynamic> sendJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'images': images,
      'category': category,
      'userID': userID,
      'ratings': ratings.map((item) {
        item.sendJson();
      }).toList(),
      '_id': productID,
    };
  }

  toMap() {}

  static fromMap(x) {}
}
