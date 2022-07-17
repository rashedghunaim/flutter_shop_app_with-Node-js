import 'package:amazon_clone/models/cart_model.dart';
import 'package:amazon_clone/state_managment/products_bloc/products_cubit.dart';
import 'package:flutter/material.dart';
import '../../../shared/custom_page_route.dart';
import '../../home/screens/product_details_screen.dart';

class CartItem extends StatelessWidget {
  final CartModel cartItem;
  CartItem({
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    void increaseCartQuantity() {
      ProductsCubit.getProductCubit(context).addOrIncreaseCart(
        context: context,
        productID: cartItem.product.productID,
        isshowToast: false,
      );
    }

    void decreaseQuantity() {
      ProductsCubit.getProductCubit(context).removeOrDecreaseFromCart(
        context: context,
        productID: cartItem.product.productID,
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRoute(
            child: ProductDetailsScreen(product: cartItem.product),
            direction: AxisDirection.right,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  cartItem.product.images[0],
                  fit: BoxFit.fitHeight,
                  height: 135,
                  width: 135,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        width: 240,
                        child: Text(
                          cartItem.product.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 235,
                        child: Text(
                          '\AED${cartItem.product.price}',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        width: 235,
                        child: Text(
                          'Elligible for free shiping',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 235,
                        child: Text(
                          'In stock',
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: decreaseQuantity,
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.remove,
                            size: 18,
                          ),
                          height: 32,
                          width: 35,
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            cartItem.quantity.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          height: 32,
                          width: 66,
                        ),
                      ),
                      InkWell(
                        onTap: increaseCartQuantity,
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add,
                            size: 18,
                          ),
                          height: 32,
                          width: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
