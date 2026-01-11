part of 'auth_cubit.dart';

abstract class AuthState {}

//-----------------Log In--------------------
class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errMsg;
  LoginFailure(this.errMsg);
}

//-----------------Sign Up--------------------
class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupFailure extends AuthState {
  final String errMsg;
  SignupFailure(this.errMsg);
}