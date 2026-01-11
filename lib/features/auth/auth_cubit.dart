import 'package:dio/dio.dart';
import 'package:final_project/cores/network/dio_helper.dart';
import 'package:final_project/cores/network/endpoints.dart';
import 'package:final_project/cores/resources/cache_helper.dart';
import 'package:final_project/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'auth_state.dart';
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  Future<void> login(bool rememberMe) async {
    try {
      emit(LoginLoading());

      final Response response = await DioHelper.postRequest(
        endPoint: AppEndPoints.accountBase + AppEndPoints.login,
        data: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserModel model = UserModel.fromJson(response.data);

        if(model.token == null){
          emit(LoginFailure("No Token Found"));
          return;
        }

        SessionManager.token = model.token;

        if (rememberMe) {
          await CacheHelper.saveToken(model.token!);
        }
        emit(LoginSuccess());
      }
      else{
        emit(LoginFailure(response.data.toString()));
      }
    } on DioException catch (e) {
      emit(LoginFailure(e.message ?? ""));
    }
  }
  Future<void> signup() async {
    try {
      emit(SignupLoading());
      if(passwordController.text != confirmPassController.text){
        emit(SignupFailure("Passwords are not identical"));
        return;
      }
      final Response response = await DioHelper.postRequest(
        endPoint: AppEndPoints.registerBase + AppEndPoints.signup,
        data: {
          "id": 0,
          "username": "mohamed31",
          "password": passwordController.text,
          "email": emailController.text,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignupSuccess());

      }
      else{
        emit(SignupFailure(response.data.toString()));
      }
    } on DioException catch (e) {
      emit(SignupFailure(e.message ?? ""));
    }
  }

}