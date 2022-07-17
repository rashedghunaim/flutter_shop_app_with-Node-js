import 'dart:convert';
import 'package:amazon_clone/models/cart_model.dart';

class UserModel {
  final String name;
  final String email;
  final String password;
  String address;
  final String userID;
  final String type;
  final String token;
  final List<dynamic> cart;
  List<CartModel>? copyCart;

  UserModel({
    required this.name,
    required this.cart,
    required this.email,
    required this.password,
    required this.address,
    required this.userID,
    required this.type,
    required this.token,
    this.copyCart,
  });

  factory UserModel.getJson(Map<String, dynamic> resBody) {
    return UserModel(
      name: resBody['name'] ?? '',
      email: resBody['email'] ?? '',
      password: resBody['password'] ?? '',
      address: resBody['address'] ?? '',
      userID: resBody['_id'] ?? '',
      type: resBody['type'] ?? '',
      token: resBody['token'] ?? '',
      cart: List<dynamic>.from(
        resBody['cart']?.map(
          (res) => CartModel.getJson(
            res: jsonDecode(jsonEncode(res)),
          ),
        ),
      ),
      copyCart: List<CartModel>.from(
        resBody['cart']?.map(
          (res) => CartModel.getJson(
            res: jsonDecode(jsonEncode(res)),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> sendJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? address,
    String? userID,
    String? type,
    String? token,
    List<dynamic>? cart,
    List<CartModel>? copyCart,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      userID: userID ?? this.userID,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: List<dynamic>.from(
        cart!.map(
          (res) => CartModel.getJson(
            res: jsonDecode(jsonEncode(res)),
          ),
        ),
      ),
      copyCart: List<CartModel>.from(
        cart.map(
          (res) => CartModel.getJson(
            res: jsonDecode(jsonEncode(res)),
          ),
        ),
      ),

    );
  }
}
