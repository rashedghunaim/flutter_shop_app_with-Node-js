import 'package:amazon_clone/models/order_model.dart';
import 'package:amazon_clone/shared/custom_page_route.dart';
import 'package:amazon_clone/shared/shared_components.dart';
import 'package:amazon_clone/state_managment/admin_bloc/admin_cubit.dart';
import 'package:amazon_clone/user_modules/account/screens/orders_details_screen.dart';
import 'package:flutter/material.dart';

import '../../home/components/product_item.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  List<OrderModel>? _usersOrders;

  void fetchAllusersOrders() async {
    _usersOrders = await AdminTransactionsCubit.getProductCubit(context)
        .fetchAllUsersOrders(context: context);
  }

  @override
  void initState() {
    fetchAllusersOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _usersOrders != null
        ? GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final OrderModel order = _usersOrders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CustomPageRoute(
                      child: OrderDetailsScreen(order: order),
                      direction: AxisDirection.left,
                    ),
                  );
                },
                child: SizedBox(
                  height: 140,
                  child: adminProductItem(
                    context: context,
                    image: order.products[0].images[0],
                    productID: order.products[0].productID,
                    productName: order.products[0].name,
                  ),
                ),
              );
            },
            itemCount: _usersOrders!.length,
          )
        : Center(
            child: loader(),
          );
  }
}
