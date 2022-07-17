import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/shared_components.dart';
import '../../../state_managment/auth_bloc/auth_cubit.dart';
import '../../../state_managment/auth_bloc/auth_states.dart';
import '../../../util/theme.dart';

class AuthSecondScreen extends StatefulWidget {
  final String userEmailController;
  AuthSecondScreen({required this.userEmailController});

  static String route = './Auth_Second_Screen';

  @override
  State<AuthSecondScreen> createState() => _AuthSecondScreenState();
}

class _AuthSecondScreenState extends State<AuthSecondScreen> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Welcom',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        centerTitle: false,
        backgroundColor: Colors.grey.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign-In',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 10),
              Text(
                widget.userEmailController,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
              SizedBox(height: 30),
              Text(
                'Password',
                style: lightTheme.textTheme.headline5!,
              ),
              BlocConsumer<AuthCubit, AuthStates>(
                buildWhen: (previous, current) {
                  if (current is TogglePasswordVisibilitySecondState) {
                    return true;
                  } else
                    return false;
                },
                listenWhen: (prev, current) {
                  if (current is TogglePasswordVisibilitySecondState) {
                    return true;
                  } else
                    return false;
                },
                listener: (context, state) {},
                builder: (context, state) {
                  final _authProvider = AuthCubit.getAuthCubit(context);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obscureText: !_authProvider.isChecked,
                      ),
                      CheckboxListTile(
                        value: _authProvider.isChecked,
                        onChanged: (val) {
                          _authProvider.togglePasswordVisibilitySecond(
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
                          if (_formKey.currentState!.validate()) {
                            _authProvider.login(
                              email: widget.userEmailController,
                              password: _passwordController.text,
                              context: context,
                            );
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
    );
  }
}
