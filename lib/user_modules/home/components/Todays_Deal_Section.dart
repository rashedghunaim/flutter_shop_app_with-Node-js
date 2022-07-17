import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/shared/custom_page_route.dart';
import 'package:amazon_clone/shared/shared_components.dart';
import 'package:amazon_clone/user_modules/home/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class TodaysDeal extends StatelessWidget {
  final ProductModel? todaysDealProduct;
  TodaysDeal({
    required this.todaysDealProduct,
  });

  Widget build(BuildContext context) {
    return todaysDealProduct == null
        ? Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: customProgressIndecator(),
            ),
          )
        : todaysDealProduct!.name.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: customProgressIndecator(),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Today\`s Deal',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          child:
                              ProductDetailsScreen(product: todaysDealProduct!),
                          direction: AxisDirection.left,
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 320,
                      child: Image.network(
                        todaysDealProduct!.images[3],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: todaysDealProduct!.images.map((image) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                            height: 110,
                            width: 110,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 15, bottom: 40, left: 15),
                    child: Text(
                      'see all',
                      style: TextStyle(
                        color: Colors.cyan[800],
                      ),
                    ),
                  ),
                ],
              );
  }
}
