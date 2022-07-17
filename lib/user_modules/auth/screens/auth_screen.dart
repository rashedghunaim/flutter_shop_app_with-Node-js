import 'package:amazon_clone/shared/custom_page_route.dart';
import 'package:amazon_clone/state_managment/auth_bloc/auth_cubit.dart';
import 'package:amazon_clone/state_managment/auth_bloc/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/shared_components.dart';
import '../../../util/theme.dart';
import 'auth_second_screen.dart';

enum AuthEnum { signIn, signUp }

class AuthScreen extends StatefulWidget {
  static const routeName = './auth_Screen';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signUpKey = GlobalKey<FormState>();
  final _signInKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthEnum _authGroupValue = AuthEnum.signUp;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: lightTheme.textTheme.headline1!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              RadioListTile(
                contentPadding: EdgeInsets.all(0),
                tileColor: _authGroupValue == AuthEnum.signUp
                    ? Colors.grey.shade200
                    : Colors.white,
                activeColor: Colors.teal[300],
                value: AuthEnum.signUp,
                groupValue: _authGroupValue,
                onChanged: (AuthEnum? val) {
                  setState(() {
                    _authGroupValue = val!;
                  });
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Create account.',
                      style: lightTheme.textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'New here ?',
                      style: lightTheme.textTheme.headline2,
                    ),
                  ],
                ),
              ),
              if (_authGroupValue == AuthEnum.signUp)
                Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _signUpKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text('First and last name',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: _userNameController,
                            hintText: 'Name',
                          ),
                          SizedBox(height: 20),
                          Text('Email address',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: _emailController,
                            hintText: 'Email',
                          ),
                          SizedBox(height: 20),
                          Text('Create a password (+6 chracters)',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          BlocConsumer<AuthCubit, AuthStates>(
                            buildWhen: (previous, current) {
                              if (current is TogglePasswordVisibilityState) {
                                return true;
                              } else
                                return false;
                            },
                            listenWhen: (prev, current) {
                              if (current is TogglePasswordVisibilityState) {
                                return true;
                              } else
                                return false;
                            },
                            listener: (context, state) {},
                            builder: (context, state) {
                              final _authProvider =
                                  AuthCubit.getAuthCubit(context);

                              return Column(
                                children: [
                                  customFormField(
                                    controller: _passwordController,
                                    hintText: 'Password',
                                    obscureText: !_authProvider.isCheckedEmail,
                                  ),
                                  SizedBox(height: 10),
                                  CheckboxListTile(
                                    value: _authProvider.isCheckedEmail,
                                    onChanged: (val) {
                                      _authProvider.togglePasswordVisibility(
                                        value: val,
                                      );
                                    },
                                    title: Text(
                                      'Show Password',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    contentPadding: EdgeInsets.all(0.0),
                                    shape: RoundedRectangleBorder(),
                                  ),
                                  SizedBox(height: 10),
                                  customElevatedButton(
                                    primaryColor: Colors.teal[300],
                                    onPressed: () {
                                      if (_signUpKey.currentState!.validate()) {
                                        final _authProvider =
                                            AuthCubit.getAuthCubit(context);
                                        _authProvider
                                            .signUp(
                                              context: context,
                                              name: _userNameController.text,
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            )
                                            .catchError((error) {});
                                      }
                                    },
                                    title: 'Continue',
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(),
              RadioListTile(
                activeColor: Colors.teal[300],
                contentPadding: EdgeInsets.all(0),
                tileColor: _authGroupValue == AuthEnum.signIn
                    ? Colors.grey.shade200
                    : Colors.white,
                value: AuthEnum.signIn,
                groupValue: _authGroupValue,
                onChanged: (AuthEnum? val) {
                  setState(() {
                    _authGroupValue = val!;
                  });
                },
                title: Row(
                  children: [
                    Text('Sign-In.', style: lightTheme.textTheme.headline5!),
                    SizedBox(width: 10),
                    Text(
                      'Already a customer ?',
                      style: lightTheme.textTheme.headline2,
                    ),
                  ],
                ),
              ),
              if (_authGroupValue == AuthEnum.signIn)
                Container(
                  decoration: BoxDecoration(
                    color: defaultBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                      left: 8,
                      top: 8,
                      bottom: 30,
                    ),
                    child: Form(
                      key: _signInKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text('Email adress',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: _emailController,
                            hintText: 'Email',
                          ),
                          SizedBox(height: 10),
                          customElevatedButton(
                            primaryColor: Colors.teal[300],
                            onPressed: () {
                              if (_signInKey.currentState!.validate()) {
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                    child: AuthSecondScreen(
                                      userEmailController:
                                          _emailController.text,
                                    ),
                                    direction: AxisDirection.right,
                                  ),
                                );
                              }
                            },
                            title: 'Continue',
                          )
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(),
            ],
          ),
        ),
      ),
    );
  }
}
