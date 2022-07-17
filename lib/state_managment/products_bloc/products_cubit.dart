import 'dart:convert';
import 'package:amazon_clone/models/order_model.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/shared/show_toast.dart';
import 'package:amazon_clone/state_managment/auth_bloc/auth_cubit.dart';
import 'package:amazon_clone/state_managment/products_bloc/products_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/shared_components.dart';
import '../../util/http_req.dart';
import '../../util/local_storage.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit(ProductsStates initialState) : super(initialState);

  static ProductsCubit getProductCubit(BuildContext context) =>
      BlocProvider.of<ProductsCubit>(context);

  Future<List<ProductModel>> fetchProductsByCategory({
    required BuildContext context,
    required String categoryName,
  }) async {
    List<ProductModel> _fetchedProducts = [];
    try {
      final res = await HttpReq.fetchData(
        endpoint: "/api/get_products?category=$categoryName",
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
            emit(FetchProductsSuccessState());
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      emit(FetchProductsErrorState());
    }
    return _fetchedProducts;
  }

  Future<List<ProductModel>> fecthAllProducts({
    required BuildContext context,
  }) async {
    List<ProductModel> _fetchedProducts = [];
    try {
      final res = await HttpReq.fetchData(
        endpoint: "/api/get_all_products",
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
            emit(FetchAllProductsSuccessState());
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      emit(FetchAllProductsErrorState());
    }
    return _fetchedProducts;
  }

  Future<List<ProductModel>> searchProducts({
    required BuildContext context,
    required String searchQuery,
  }) async {
    List<ProductModel> _fetchedProducts = [];
    try {
      final res = await HttpReq.fetchData(
        endpoint: "/api/products/search/$searchQuery",
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
            emit(SearchProductSuccessState());
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      emit(SearchProductsErrorState());
    }
    return _fetchedProducts;
  }

  Future<void> ratingProduct({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  }) async {
    try {
      final res = await HttpReq.postData(
        endpoint: "/api/rate_product",
        token: CashHelper.getCashData(key: "auth_token"),
        reqBody: {
          "productId": product.productID,
          "rating": rating,
        },
      );
      print(res.body);
      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          emit(RatingProductSuccessState());
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      emit(RatingProductErroeState());
    }
  }

  Future<ProductModel> getTodaysDeal({
    required BuildContext context,
  }) async {
    ProductModel todayDealProduct = ProductModel(
      category: '',
      description: '',
      images: [],
      name: '',
      price: 0,
      quantity: 0,
      productID: '',
      userID: '',
      ratings: [],
    );
    try {
      final res = await HttpReq.fetchData(
        endpoint: '/api/todays_deal',
        token: CashHelper.getCashData(key: "auth_token"),
      );

      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          todayDealProduct =
              ProductModel.getJson(response: jsonDecode(res.body));
          emit(FetchTodaysDealProductSuccessState());
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      emit(FetchTodaysDealProductErrorState());
    }
    return todayDealProduct;
  }

  Future<void> addOrIncreaseCart({
    bool isshowToast = true,
    required BuildContext context,
    required String productID,
  }) async {
    try {
      final res = await HttpReq.postData(
        endpoint: "/api/add_to_cart",
        token: CashHelper.getCashData(key: "auth_token"),
        reqBody: {
          'productID': productID,
        },
      );

      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          final UserModel updatedCurrentUser =
              AuthCubit.getAuthCubit(context).getCurrentUser.copyWith(
                    cart: json.decode(res.body)['cart'],
                  );

          AuthCubit.getAuthCubit(context).setCurrentUser = updatedCurrentUser;

          isshowToast
              ? showToast(
                  message: 'Added to your cart',
                  state: ToastStates.SUCCESS,
                )
              : null;
          emit(AddtoToCartSuccessState());
        },
      );
    } catch (e) {
      emit(AddToCartErrorState());
      showSnackBar(context, e.toString());
      print(e.toString());
    }
  }

  Future<void> removeOrDecreaseFromCart({
    required BuildContext context,
    required String productID,
  }) async {
    try {
      final res = await HttpReq.deleteData(
        endpoint: "/api/remove_from_cart/$productID",
        token: CashHelper.getCashData(key: "auth_token"),
      );

      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          final UserModel updatedCurrentUser =
              AuthCubit.getAuthCubit(context).getCurrentUser.copyWith(
                    cart: json.decode(res.body)['cart'],
                  );

          AuthCubit.getAuthCubit(context).setCurrentUser = updatedCurrentUser;
          emit(RemoveFromCartSuccessState());
        },
      );
    } catch (e) {
      emit(RemoveFromCartErrorState());
      showSnackBar(context, e.toString());
      print(e.toString());
    }
  }

  Future<void> saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    try {
      final res = await HttpReq.postData(
        endpoint: "/api/save_user_address",
        reqBody: {
          'address': address,
        },
        token: CashHelper.getCashData(key: "auth_token"),
      );
      print(res.body);
      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          final UserModel _updatedCurrentUser =
              AuthCubit.getAuthCubit(context).getCurrentUser.copyWith(
                    address: json.decode(res.body)['address'],
                  );

          AuthCubit.getAuthCubit(context).setCurrentUser = _updatedCurrentUser;

          print('user address is ' +
              AuthCubit.getAuthCubit(context).getCurrentUser.address);
          emit(SaveUserAddressSuccessState());
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      emit(SaveUserAddressErrorState());
    }
  }

  Future<void> placeNewOrder({
    required BuildContext context,
    required String address,
    required double totalPrice,
  }) async {
    try {
      final res = await HttpReq.postData(
        endpoint: "/api/order",
        token: CashHelper.getCashData(key: "auth_token"),
        reqBody: {
          'address': address,
          'totalPrice': totalPrice,
          'cart': AuthCubit.getAuthCubit(context)
              .getCurrentUser
              .copyCart!
              .map((item) {
            return {
              'product': item.product.sendJson(),
              'quantity': item.quantity,
              '_id': item.id,
            };
          }).toList(),
        },
      );

      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          final UserModel _updatedUser =
              AuthCubit.getAuthCubit(context).getCurrentUser.copyWith(cart: []);
          AuthCubit.getAuthCubit(context).setCurrentUser = _updatedUser;
          showToast(
            message: 'Your order has been placed',
            state: ToastStates.SUCCESS,
          );
          emit(PlaceNewOrderSuccessState());
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
      emit(PlaceNewOrderErrorState());
    }
  }

  Future<List<OrderModel>> fetchUserOrders({
    required BuildContext context,
  }) async {
    List<OrderModel> _oredredProducts = [];
    try {
      final res = await HttpReq.fetchData(
        endpoint: "/api/orders/me",
        token: CashHelper.getCashData(
          key: "auth_token",
        ),
      );
      print(res.body);
      requestsStatusHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (Map<String, dynamic> item in jsonDecode(res.body)) {
            _oredredProducts.add(
              OrderModel.fromJson(
                jsonEncode(item),
              ),
            );
          }
          emit(FetchUserOrdersSuccessState());
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e.toString());
      emit(FetchUserOrdersErrorState());
    }
    return _oredredProducts;
  }
}
