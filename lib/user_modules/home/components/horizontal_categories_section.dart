import 'package:flutter/material.dart';

import 'Category_Item.dart';

Widget horizontalCategoriesSection({required BuildContext context}) {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Art', 'image': 'lib/assets/images/art.png'},
    {'title': 'Baby', 'image': 'lib/assets/images/baby.png'},
    {'title': 'Books', 'image': 'lib/assets/images/books.jpg'},
    {'title': 'Fashion', 'image': 'lib/assets/images/fashion.png'},
    {'title': 'Home', 'image': 'lib/assets/images/home.png'},
    {'title': 'Mobiles', 'image': 'lib/assets/images/mobiles.png'},
    {'title': 'Self-Care', 'image': 'lib/assets/images/self-care.png'},
    {'title': 'Sports', 'image': 'lib/assets/images/sports.png'},
  ];

  return Container(
    padding: EdgeInsets.all(8.0),
    height: 110.0,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryItem(
          title: categories[index]['title'],
          image: categories[index]['image'],
        );
      },
      itemCount: categories.length,
    ),
  );
}
