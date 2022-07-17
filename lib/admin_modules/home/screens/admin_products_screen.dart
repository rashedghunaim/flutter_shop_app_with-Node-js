import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/shared/custom_page_route.dart';
import 'package:amazon_clone/shared/shared_components.dart';
import 'package:amazon_clone/state_managment/admin_bloc/admin_cubit.dart';
import 'package:amazon_clone/state_managment/admin_bloc/admin_states.dart';
import 'package:amazon_clone/user_modules/home/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/product_item.dart';
import 'add_new_product_screen.dart';

class AdminProductsScreen extends StatefulWidget {
  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
  List<ProductModel>? _fetchedProducts;
  void fetchAllProducts() async {
    _fetchedProducts = await AdminTransactionsCubit.getProductCubit(context)
        .fetchAllAdminProducts(context);
  }

  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminTransactionsCubit, AdminTransactionsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DeleteProductSuccessState) {
          _fetchedProducts!.removeWhere(
            (element) => element.productID == state.productID,
          );
        }
        return Scaffold(
          body: _fetchedProducts == null
              ? Center(
                  child: loader(),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (conext, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(
                              CustomPageRoute(
                                child: ProductDetailsScreen(
                                  product: _fetchedProducts![index],
                                ),
                                direction: AxisDirection.right,
                              ),
                            )
                            .then((future) {});
                      },
                      child: adminProductItem(
                        context: conext,
                        productID: _fetchedProducts![index].productID,
                        image: _fetchedProducts![index].images[0],
                        productName: _fetchedProducts![index].name,
                      ),
                    );
                  },
                  itemCount: _fetchedProducts!.length,
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: 'Add product',
            onPressed: () {
              Navigator.of(context)
                  .push(
                    CustomPageRoute(
                      child: AddNewProductsScreen(),
                      direction: AxisDirection.right,
                    ),
                  )
                  .then((future) {});
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
