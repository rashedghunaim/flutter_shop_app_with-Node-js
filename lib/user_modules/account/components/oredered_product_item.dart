import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrderedProduct extends StatelessWidget {
  final String image;
  OrderedProduct({
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
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
            fit: BoxFit.contain,
            height: 150,
            imageUrl: image,
          ),
        ),
      ),
    );
  }
}
