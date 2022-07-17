import 'package:amazon_clone/models/order_model.dart';
import 'package:amazon_clone/shared/custom_page_route.dart';
import 'package:amazon_clone/user_modules/home/screens/product_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../shared/custom_shimmer_effect.dart';

Widget orderPurchaseDetailsSection({
  required BuildContext context,
  required OrderModel order,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Purchase Details',
        style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
      ),
      SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (int i = 0; i < order.products.length; i++)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CustomPageRoute(
                      child: ProductDetailsScreen(
                        product: order.products[i],
                      ),
                      direction: AxisDirection.left,
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        height: 120,
                        width: 120,
                        imageUrl: order.products[i].images[0],
                        placeholder: (context, url) {
                          return customRectangleShimmerEffect(
                            context: context,
                            height: 150,
                            width: double.infinity,
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              order.products[i].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 35),
                            Text(
                              'Qnty:  ${order.quantity[i].toString()}',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}
