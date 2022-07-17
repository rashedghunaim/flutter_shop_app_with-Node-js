import 'package:amazon_clone/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductRatingStar extends StatelessWidget {
  final double rating;
  const ProductRatingStar({
    required this.rating,
  });
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5,
      rating: rating,
      itemSize: 20,
      itemBuilder: (context, _) {
        return Icon(
          Icons.star,
          color: secondaryColor,
        );
      },
    );
  }
}
