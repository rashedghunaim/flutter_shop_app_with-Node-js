import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/order_model.dart';
import '../../models/product_model.dart';
import '../../models/sales.dart';
import '../../shared/shared_components.dart';
import '../../util/http_req.dart';
import '../../util/local_storage.dart';
import '../auth_bloc/auth_cubit.dart';
import 'admin_states.dart';

class AdminTransactionsCubit extends Cubit<AdminTransactionsStates> {
  AdminTransactionsCubit(AdminTransactionsStates initialState)
      : super(initialState);

  static AdminTransactionsCubit getProductCubit(BuildContext context) =>
      BlocProvider.of<AdminTransactionsCubit>(context);

  Future<void> addNewProduct({
    required BuildContext context,
    required String productName,
    required String description,
    required int price,
    required int quantity,
    required List<File> productImages,
    required String category,
  }) async {
    final _authCubit = AuthCubit.getAuthCubit(context);
    try {
      final cloudinary = CloudinaryPublic(
        'dqlxrr49v',
        'avoeu4ql',
      );
      List<String> _imageUrls = [];
      for (int i = 0; i < productImages.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            productImages[i].path,
            folder: productName,
          ),
        );
        _imageUrls.add(res.secureUrl);
      }

      ProductModel _product = ProductModel(
        category: category,
        description: description,
        images: _imageUrls,
        name: productName,
        price: price,
        quantity: quantity,
        productID: '',
        userID: _authCubit.getCurrentUser.userID,
        ratings: [],
      );

      final res = await HttpReq.postData(
        endpoint: '/admin/add_product',
        token: CashHelper.getCashData(key: "auth_token"),
        reqBody: _product.sendJson(),
      );
      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          _product = ProductModel.getJson(response: json.decode(res.body));
          showSnackBar(context, 'new product has added ');
          Navigator.pop(context);
          emit(AddNewProductSuccessState());
        },
      );
    } catch (e) {
      showSnackBar(context, "sell products error is " + e.toString());
      print("sell products error is " + e.toString());
      emit(AddNewproductErrorState());
    }
  }

  Future<List<ProductModel>> fetchAllAdminProducts(BuildContext context) async {
    List<ProductModel> _fetchedProducts = [];
    try {
      emit(FetchProductsWaitingState());
      final res = await HttpReq.fetchData(
        endpoint: "/admin/get_products",
        token: CashHelper.getCashData(key: "auth_token"),
      );
      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (Map<String, dynamic> item in jsonDecode(res.body)) {
            _fetchedProducts.add(
              ProductModel.fromJson(
                jsonEncode(item),
              ),
            );
          }
          emit(FetchAllproductsSuccessState());
        },
      );
    } catch (e) {
      emit(FetchAllproductsErrorState());
      showSnackBar(context, e.toString());
    }
    return _fetchedProducts;
  }

  Future<void> deleteProduct({
    required BuildContext context,
    required productID,
  }) async {
    try {
      final res = await HttpReq.postData(
        endpoint: "/admin/delete_product",
        token: CashHelper.getCashData(key: "auth_token"),
        reqBody: {
          "productID": productID,
        },
      );
      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          final deletedProduct = ProductModel.getJson(
            response: jsonDecode(
              res.body,
            ),
          );
          showSnackBar(context, 'selected product has been deleted');
          emit(DeleteProductSuccessState(
            productID: deletedProduct.productID,
          ));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      emit(DeleteProductErrorState());
    }
  }

  Future<List<OrderModel>> fetchAllUsersOrders({
    required BuildContext context,
  }) async {
    List<OrderModel> _fetchedOrders = [];
    try {
      final res = await HttpReq.fetchData(
        endpoint: "/admin/get_all_orders",
        token: CashHelper.getCashData(key: "auth_token"),
      );
      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (Map<String, dynamic> item in jsonDecode(res.body)) {
            _fetchedOrders.add(
              OrderModel.fromJson(
                jsonEncode(item),
              ),
            );
          }
          emit(FecthAllUsersOrdersSuccessState());
        },
      );
    } catch (e) {
      emit(FecthAllUsersOrdersErrorState());
      showSnackBar(context, e.toString());
    }
    return _fetchedOrders;
  }

  Future<void> changeOrderStatus({
    required BuildContext context,
    required int currentStatus,
    required String orderID,
    required VoidCallback onSuccess,
  }) async {
    try {
      final res = await HttpReq.postData(
        endpoint: "/admin_change_order_status",
        token: CashHelper.getCashData(key: "auth_token"),
        reqBody: {
          'id': orderID,
          'status': currentStatus,
        },
      );

      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          emit(ChangeOrderStateSuccessState());
        },
      );
    } catch (e) {
      emit(ChangeOrderStateErrorState());
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> collectEarnings({
    required BuildContext context,
  }) async {
    List<SalesModel>? _sales;
    int totalEarnings = 0;
    try {
      final res = await HttpReq.fetchData(
        endpoint: "/admin/collect_earnings",
        token: CashHelper.getCashData(
          key: "auth_token",
        ),
      );
      print('res is ' + res.body);
      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarnings = response['totalEarnings'];
          _sales = [
            SalesModel(earnings: response['ArtEarnings'], label: 'Art'),
            SalesModel(
              earnings: response['BabyEarnings'],
              label: 'Baby',
            ),
            SalesModel(
              earnings: response['BooksEarnings'],
              label: 'Books',
            ),
            SalesModel(
              earnings: response['FashionEarnings'],
              label: 'Fashion',
            ),
            SalesModel(
              earnings: response['HomeEarnings'],
              label: 'Home',
            ),
            SalesModel(
              earnings: response['MobilesEarnings'],
              label: 'Mobiles',
            ),
            SalesModel(
              earnings: response['SelfCareEarnings'],
              label: 'Self-Care',
            ),
            SalesModel(
              earnings: response['SportsEarnings'],
              label: 'Sports',
            ),
          ];
          emit(CollectTotalEraningsSuccessState());
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      emit(CollectTotalEraningsErrorState());
    }
    return {
      'sales': _sales,
      'total_earnings': totalEarnings,
    };
  }
}
