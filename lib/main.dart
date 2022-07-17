import 'package:amazon_clone/state_managment/admin_bloc/admin_states.dart';
import 'package:amazon_clone/state_managment/auth_bloc/auth_states.dart';
import 'package:amazon_clone/state_managment/products_bloc/products_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin_modules/home/screens/add_new_product_screen.dart';
import 'layout/admin_layout.dart';
import 'layout/user_Layout.dart';
import 'state_managment/admin_bloc/admin_cubit.dart';
import 'state_managment/auth_bloc/auth_cubit.dart';
import 'state_managment/block_observer.dart';
import 'state_managment/products_bloc/products_cubit.dart';
import 'user_modules/auth/screens/auth_screen.dart';
import 'util/local_storage.dart';
import 'util/theme.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      CashHelper.sharedPref = await SharedPreferences.getInstance();
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit()..getUserData(context),
            ),
            BlocProvider(
              create: (context) =>
                  AdminTransactionsCubit(AdminTransactionInitialState()),
            ),
            BlocProvider(
              create: (context) => ProductsCubit(ProductsStatesInitialState()),
            ),
          ],
          child: AppRoot(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authCubit = AuthCubit.getAuthCubit(context);
    final String? token = CashHelper.getCashData(key: "auth_token");
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: lightTheme,
          title: 'Amazone Clone',
          home: token == null || token.isEmpty
              ? AuthScreen()
              : _authCubit.getCurrentUser.type == 'user'
                  ? UserHomeScreenLayout()
                  : AdminScreenLayout(),
          routes: {
            UserHomeScreenLayout.routeName: (context) => UserHomeScreenLayout(),
            AdminScreenLayout.routeName: (context) => AdminScreenLayout(),
            AuthScreen.routeName: (context) => AuthScreen(),
            AddNewProductsScreen.routeName: (context) => AddNewProductsScreen(),
          },
        );
      },
    );
  }
}
