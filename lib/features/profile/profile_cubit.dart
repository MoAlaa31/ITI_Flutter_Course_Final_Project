

import 'package:dio/dio.dart';
import 'package:final_project/cores/network/dio_helper.dart';
import 'package:final_project/cores/network/endpoints.dart';
import 'package:final_project/models/profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserProfileModel? _profile;
  UserProfileModel? get profile => _profile;

  Future<void> getProfileData() async {
    emit(ProfileLoading());

    // any other time
    if (_profile != null) {
      emit(ProfileSuccess(_profile!));
      return;
    }

    // first time only
    try {
      final response = await DioHelper.getWithAuthRequest(
        endPoint: AppEndPoints.accountBase + AppEndPoints.profile,
        requiresAuth: true,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        _profile = UserProfileModel.fromJson(response.data);
        emit(ProfileSuccess(_profile!));
      }
    } on DioException catch (e) {
      // print(e.message);
      emit(ProfileFailure("Failed to load profile"));
    }
  }

  void clearSession() {
    _profile = null;
    emit(ProfileInitial());
  }
}
