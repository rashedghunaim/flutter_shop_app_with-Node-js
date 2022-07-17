import 'package:amazon_clone/models/cart_model.dart';
import 'package:flutter/material.dart';

import '../../../state_managment/auth_bloc/auth_cubit.dart';

class CartSubtotalSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = AuthCubit.getAuthCubit(context).getCurrentUser;
    int totalSum = 0;

    for (CartModel item in user.cart) {
      totalSum = totalSum + item.quantity * item.product.price;
    }

    return totalSum == 0
        ? Container()
        : Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'SubTotal ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\AED $totalSum ',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
  }
}
