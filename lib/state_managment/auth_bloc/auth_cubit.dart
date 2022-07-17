import 'dart:convert';
import 'package:amazon_clone/layout/admin_layout.dart';
import 'package:amazon_clone/layout/user_Layout.dart';
import 'package:amazon_clone/models/Auth_model.dart';
import 'package:amazon_clone/shared/shared_components.dart';
import 'package:amazon_clone/state_managment/auth_bloc/auth_states.dart';
import 'package:amazon_clone/user_modules/auth/screens/auth_screen.dart';
import 'package:amazon_clone/util/http_req.dart';
import 'package:amazon_clone/util/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/user_model.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit getAuthCubit(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context);

  Future<void> signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserModel _signedUpUser = new UserModel(
        name: name,
        email: email,
        password: password,
        address: '',
        userID: '',
        type: '',
        token: '',
        cart: [],
      );

      final http.Response _response = await HttpReq.postData(
        endpoint: '/api/signup',
        reqBody: _signedUpUser.sendJson(),
      );
      final AuthModel _authModel;
      _authModel = AuthModel.getJson(resData: json.decode(_response.body));
      _signedUpUser = _authModel.userData!;
      requestsStatusHandler(
        response: _response,
        context: context,
        onSuccess: () {
          emit(SignUpSuccessState());
          showSnackBar(
            context,
            _authModel.msg,
          );
        },
      );
    } catch (error) {
      print('client side sign up error is $error');
      emit(SignUpErrorState());
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginInitialState());
    try {
      final _response =
          await HttpReq.postData(endpoint: '/api/login', reqBody: {
        'email': '$email',
        'password': '$password',
      });

      final _authModel =
          AuthModel.getJson(resData: json.decode(_response.body));
      final UserModel? _loggedInUser = _authModel.userData;

      requestsStatusHandler(
        response: _response,
        context: context,
        onSuccess: () async {
          setCurrentUser = _loggedInUser!;
          final bool isSaved = await CashHelper.saveDataInCash(
            key: 'auth_token',
            value: _loggedInUser.token,
          );
          if (isSaved) {
            showSnackBar(context, _authModel.msg);
            Navigator.pushNamedAndRemoveUntil(
              context,
              getCurrentUser.type == 'admin'
                  ? AdminScreenLayout.routeName
                  : UserHomeScreenLayout.routeName,
              (route) => false,
            );
            emit(LoginSuccessState());
          }
        },
      );
    } catch (e) {
      print('client side login error is' + e.toString());
      emit(LoginErrorState());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      String? token = CashHelper.getCashData(key: 'auth_token');
      if (token!.isEmpty) {
        await CashHelper.saveDataInCash(key: 'auth_token', value: '');
      } else {
        final response = await HttpReq.postData(
          endpoint: '/token_validation',
          reqBody: {},
          token: token,
        );
        final isTokenVefiriedResp = jsonDecode(response.body);
        if (isTokenVefiriedResp == true) {
          final userDataResponse = await HttpReq.fetchData(
            endpoint: "/user_data",
            token: token,
          );
          setCurrentUser = UserModel.getJson(
            json.decode(
              userDataResponse.body,
            ),
          );

          emit(FetchUserDataSuccessState());
        }
      }
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  UserModel _currentUser = UserModel(
    name: '',
    email: '',
    password: '',
    address: '',
    userID: '',
    type: '',
    token: ',',
    cart: [],
  );

  UserModel get getCurrentUser => _currentUser;
  set setCurrentUser(UserModel user) {
    _currentUser = user;
  }

  bool isCheckedEmail = false;
  void togglePasswordVisibility({required bool? value}) {
    isCheckedEmail = value!;
    emit(TogglePasswordVisibilityState());
  }

  bool isChecked = false;
  void togglePasswordVisibilitySecond({required bool? value}) {
    isChecked = value!;
    emit(TogglePasswordVisibilitySecondState());
  }

  Future<void> logOut({required BuildContext context}) async {
    try {
      await CashHelper.saveDataInCash(key: "auth_token", value: '');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return AuthScreen();
          },
        ),
        (_) => false,
      );
      emit(LogoutSuccessState());
    } catch (e) {
      print('log out error' + e.toString());
      emit(LogoutErrorSate());
      showSnackBar(context, e.toString());
    }
  }
}
