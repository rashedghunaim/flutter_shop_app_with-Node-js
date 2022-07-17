// import 'package:dio/dio.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class SignUpSuccessState extends AuthStates {}

class SignUpErrorState extends AuthStates {}

class TogglePasswordVisibilityState extends AuthStates {}

class TogglePasswordVisibilitySecondState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {}

class LoginInitialState extends AuthStates {}

class FetchUserDataSuccessState extends AuthStates {}

class LogoutSuccessState extends AuthStates {
}

class LogoutErrorSate extends AuthStates {}
