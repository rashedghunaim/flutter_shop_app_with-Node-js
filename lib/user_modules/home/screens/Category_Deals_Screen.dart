import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/shared/shared_components.dart';
import 'package:amazon_clone/state_managment/products_bloc/products_cubit.dart';
import 'package:amazon_clone/state_managment/products_bloc/products_states.dart';
import 'package:amazon_clone/user_modules/home/components/adress_section.dart';
import 'package:amazon_clone/user_modules/home/components/home_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../components/product_item.dart';

class CategoryDealsScreen extends StatefulWidget {
  final String title;
  CategoryDealsScreen({
    required this.title,
  });
  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<ProductModel>? _fetchProducts;

  Future<void> fetchProductsByCategory() async {
    final res =
        await ProductsCubit.getProductCubit(context).fetchProductsByCategory(
      context: context,
      categoryName: widget.title,
    );
    _fetchProducts = res;
  }

  @override
  void initState() {
    fetchProductsByCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        print(_fetchProducts);
        return Scaffold(
          appBar: homeScreenAppBar(
            context: context,
            activateSearchApi: true,
          ),
          body: _fetchProducts == null
              ? Center(
                  child: customProgressIndecator(),
                )
              : LiquidPullToRefresh(
                  backgroundColor: Colors.black54,
                  color: Colors.grey.shade100,
                  animSpeedFactor: 10.0,
                  onRefresh: () async {
                    fetchProductsByCategory();
                  },
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      addressSection(context: context),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Keep shpoping for ${widget.title}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Results (${_fetchProducts!.length})',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: StaggeredGrid.count(
                          crossAxisCount: 1,
                          mainAxisSpacing: 50,
                          crossAxisSpacing: 4,
                          children: _fetchProducts!.map((item) {
                            return ProductItem(
                              product: item,
                              isExploreScreen: false,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
