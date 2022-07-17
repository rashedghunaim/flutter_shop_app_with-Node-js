import 'package:amazon_clone/user_modules/home/components/home_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../models/order_model.dart';
import '../../../shared/custom_page_route.dart';
import '../../../shared/shared_components.dart';
import '../../../state_managment/auth_bloc/auth_cubit.dart';
import '../../../state_managment/products_bloc/products_cubit.dart';
import '../../../state_managment/products_bloc/products_states.dart';
import '../components/details_info_buttons.dart';
import '../components/oredered_product_item.dart';
import '../components/user_details_section.dart';
import 'orders_details_screen.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = './account-screen';
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<OrderModel>? _orders;

  void fetchUserOrders() async {
    final res = await ProductsCubit.getProductCubit(context)
        .fetchUserOrders(context: context);
    _orders = res;
  }

  @override
  void initState() {
    fetchUserOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = AuthCubit.getAuthCubit(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeScreenAppBar(
        context: context,
        activateSearchApi: false,
      ),
      body: LiquidPullToRefresh(
        color: Colors.grey.shade100,
        backgroundColor: Colors.black54,
        showChildOpacityTransition: true,
        animSpeedFactor: 10.0,
        onRefresh: () async {
          fetchUserOrders();
        },
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return false;
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              userDetailsSection(
                context: context,
                userName: _authProvider.getCurrentUser.name,
              ),
              detailsInfoButtons(context: context),
              SizedBox(height: 30),
              BlocConsumer<ProductsCubit, ProductsStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return _orders == null
                      ? Center(
                          child: customProgressIndecator(),
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Your Orders',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Text(
                                    'see all',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: StaggeredGrid.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 4,
                                children: _orders!.map((item) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        CustomPageRoute(
                                          child: OrderDetailsScreen(
                                            order: item,
                                          ),
                                          direction: AxisDirection.left,
                                        ),
                                      );
                                    },
                                    child: OrderedProduct(
                                      image: item.products[0].images[0],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
