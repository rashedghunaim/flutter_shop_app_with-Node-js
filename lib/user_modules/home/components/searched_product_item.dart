import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/shared/custom_page_route.dart';
import 'package:amazon_clone/user_modules/home/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/rating_model.dart';
import '../../../state_managment/auth_bloc/auth_cubit.dart';
import 'product_rating_Stars.dart';

class SearchedProductItem extends StatelessWidget {
  final ProductModel searchedProduct;
  SearchedProductItem({
    required this.searchedProduct,
  });

  @override
  Widget build(BuildContext context) {
    double _avgRating = 0;
    double _myRating = 0;

    double totalRating = 0;
    for (RatingModel item in searchedProduct.ratings) {
      totalRating += item.ratings;

      if (item.userID ==
          AuthCubit.getAuthCubit(context).getCurrentUser.userID) {
        _myRating = item.ratings;
      }
    }

    if (totalRating != 0) {
      _avgRating = totalRating / searchedProduct.ratings.length;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRoute(
            child: ProductDetailsScreen(product: searchedProduct),
            direction: AxisDirection.right,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.network(
                  searchedProduct.images[0],
                  fit: BoxFit.fitHeight,
                  height: 135,
                  width: 135,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 135,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Text(
                        searchedProduct.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 5,
                      ),
                      child: ProductRatingStar(
                        rating: _avgRating,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 5,
                      ),
                      child: Text(
                        '\$${searchedProduct.price}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        'Elligible for free shiping',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 5,
                      ),
                      child: Text(
                        'In stock',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
