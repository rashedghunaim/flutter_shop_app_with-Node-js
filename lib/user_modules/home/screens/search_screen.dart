import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/shared/shared_components.dart';
import 'package:amazon_clone/state_managment/products_bloc/products_cubit.dart';
import 'package:amazon_clone/state_managment/products_bloc/products_states.dart';
import 'package:amazon_clone/user_modules/home/components/adress_section.dart';
import 'package:amazon_clone/user_modules/home/components/home_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/searched_product_item.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  SearchScreen({
    required this.searchQuery,
  });
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel>? _searchedProducts;

  Future<void> searchProducts() async {
    final res = await ProductsCubit.getProductCubit(context).searchProducts(
      context: context,
      searchQuery: widget.searchQuery,
    );
    _searchedProducts = res;
  }

  @override
  void initState() {
    searchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {},
      builder: (conetx, state) {
        return Scaffold(
          appBar: homeScreenAppBar(
            context: context,
            activateSearchApi: false,
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              addressSection(context: context),
              _searchedProducts == null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 300),
                      child: Center(
                        child: loader(),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (conetx, index) {
                          final product = _searchedProducts![index];
                          return SearchedProductItem(
                            searchedProduct: product,
                          );
                        },
                        itemCount: _searchedProducts!.length,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
