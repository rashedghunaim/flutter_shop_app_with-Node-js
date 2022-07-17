import 'package:amazon_clone/admin_modules/home/screens/admin_products_screen.dart';
import 'package:amazon_clone/state_managment/admin_bloc/admin_cubit.dart';
import 'package:amazon_clone/state_managment/admin_bloc/admin_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../admin_modules/analytics/admin_analytics_screen.dart';
import '../admin_modules/orders/screens/admin_orders_screen.dart';
import '../assets/icons/my_icons.dart';
import 'components.dart';

class AdminScreenLayout extends StatefulWidget {
  static const routeName = './admin_layout';
  const AdminScreenLayout({Key? key}) : super(key: key);

  @override
  State<AdminScreenLayout> createState() => _AdminScreenLayoutState();
}

class _AdminScreenLayoutState extends State<AdminScreenLayout> {
  List<Widget> _tabs = [
    AdminProductsScreen(),
    AdminAnalyticsScreen(),
    BlocConsumer<AdminTransactionsCubit, AdminTransactionsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AdminOrdersScreen();
      },
    ),
  ];
  int _selectedIndex = 0;
  final bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminScreenAppBar(
        context: context,
        title: _selectedIndex == 0
            ? 'Products'
            : _selectedIndex == 1
                ? 'Analytics'
                : _selectedIndex == 2
                    ? 'Orders'
                    : '',
      ),
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          elevation: 2.0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontSize: 0.0),
          unselectedLabelStyle: TextStyle(fontSize: 0.0),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            myBottomNavigationBarItem(
              context: context,
              icon: MyIcons.home2,
              selectedIndex: _selectedIndex,
              itemBarIndex: 0,
            ),
            myBottomNavigationBarItem(
              context: context,
              icon: Icons.analytics,
              selectedIndex: _selectedIndex,
              itemBarIndex: 1,
            ),
            myBottomNavigationBarItem(
              context: context,
              icon: Icons.inbox_rounded,
              selectedIndex: _selectedIndex,
              itemBarIndex: 2,
              cartBadge: false,
            ),
          ],
        ),
      ),
      body: PageStorage(
        bucket: bucket,
        child: _tabs[_selectedIndex],
      ),
    );
  }
}
