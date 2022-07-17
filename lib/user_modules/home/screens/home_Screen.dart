import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/shared/shared_components.dart';
import 'package:amazon_clone/state_managment/products_bloc/products_cubit.dart';
import 'package:amazon_clone/state_managment/products_bloc/products_states.dart';
import 'package:amazon_clone/user_modules/home/components/horizontal_categories_section.dart';
import 'package:amazon_clone/user_modules/home/components/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../components/ad_slider.dart';
import '../components/adress_section.dart';
import '../components/Todays_Deal_Section.dart';
import '../components/home_screen_appbar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = './homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductModel? _todaysDeal;
  List<ProductModel>? _allProducts;
  void getTodaysDeal() async {
    _todaysDeal = await ProductsCubit.getProductCubit(context)
        .getTodaysDeal(context: context);
  }

  void fetchAllProducts() async {
    _allProducts = await ProductsCubit.getProductCubit(context)
        .fecthAllProducts(context: context);
  }

  @override
  void initState() {
    fetchAllProducts();
    getTodaysDeal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsStates>(
      buildWhen: (previous, current) {
        if (current is FetchAllProductsSuccessState) {
          return true;
        }
        return false;
      },
      listenWhen: (previous, current) {
        if (current is FetchAllProductsSuccessState) {
          return true;
        }
        return false;
      },
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: homeScreenAppBar(
            context: context,
            activateSearchApi: true,
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return false;
            },
            child: _allProducts == null
                ? customProgressIndecator()
                : LiquidPullToRefresh(
                    color: Colors.grey.shade100,
                    backgroundColor: Colors.black54,
                    animSpeedFactor: 10.0,
                    onRefresh: () async {
                      fetchAllProducts();
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        addressSection(context: context),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 10,
                          ),
                          child: Text(
                            'Categories',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        horizontalCategoriesSection(context: context),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: TodaysDeal(
                            todaysDealProduct: _todaysDeal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            'Take a look',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: adSliderSection(context: context),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            'Explore new deals',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: StaggeredGrid.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 50,
                            crossAxisSpacing: 4,
                            children: _allProducts!.map((item) {
                              return ProductItem(
                                product: item,
                                isExploreScreen: true,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
