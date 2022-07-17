import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/shared/custom_page_route.dart';
import 'package:amazon_clone/shared/custom_shimmer_effect.dart';
import 'package:amazon_clone/user_modules/home/components/product_rating_Stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/rating_model.dart';
import '../../../state_managment/auth_bloc/auth_cubit.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;
  final bool isExploreScreen;
  ProductItem({
    required this.isExploreScreen,
    required this.product,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  double _avgRating = 0;
  double _myRating = 0;
  @override
  void initState() {
    super.initState();

    double totalRating = 0;
    for (RatingModel item in widget.product.ratings) {
      totalRating += item.ratings;

      if (item.userID ==
          AuthCubit.getAuthCubit(context).getCurrentUser.userID) {
        _myRating = item.ratings;
      }
    }

    if (totalRating != 0) {
      _avgRating = totalRating / widget.product.ratings.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRoute(
            child: ProductDetailsScreen(
              product: widget.product,
            ),
            direction: AxisDirection.left,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(
                color: Colors.transparent,
                width: 0.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(Colors.grey.shade100, BlendMode.multiply),
              child: CachedNetworkImage(
                imageUrl: widget.product.images[0],
                fit: BoxFit.contain,
                height: 200,
                placeholder: (context, url) {
                  return customRectangleShimmerEffect(
                    context: context,
                    height: 150,
                    width: double.infinity,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.product.name,
            maxLines: widget.isExploreScreen ? 1 : 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 5),
          ProductRatingStar(
            rating: _avgRating,
          ),
          SizedBox(height: 5),
          Text(
            'AED${widget.product.price}',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}
