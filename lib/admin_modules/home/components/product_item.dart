import 'package:amazon_clone/state_managment/admin_bloc/admin_cubit.dart';
import 'package:flutter/material.dart';

Widget adminProductItem({
  required String image,
  required String productName,
  required String productID,
  required BuildContext context,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(height: 15),
      SizedBox(
        height: 140,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            child: Container(
              width: 188,
              padding: EdgeInsets.all(10),
              child: Image.network(
                image,
                fit: BoxFit.fitHeight,
                width: 100,
              ),
            ),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 10),
          Expanded(
            child: Text(
              productName,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(color: Colors.black),
            ),
          ),
          IconButton(
            onPressed: () {
              AdminTransactionsCubit.getProductCubit(context).deleteProduct(
                context: context,
                productID: productID,
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    ],
  );
}
