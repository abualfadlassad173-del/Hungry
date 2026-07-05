import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/auth_state.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:image_picker/image_picker.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool isGuest = false;
  String? selectedImage;
  UserModel? userModel;
  final AuthRepo authRepo = AuthRepo();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: "fadl99090i@gmail.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "123123123",
  );

  //Login Function

  Future login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await authRepo.login(email, password);
      emit(LoginSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(LoginError(errorMessage));
    }
  }

  //Signup Function

  Future signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());
    try {
      await authRepo.signup(name, email, password);
      emit(SignupSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(SignupError(errorMessage));
    }
  }

  //Auto Login Function
  Future autoLogin() async {
    emit(AutoLoginLoading());
    try {
      final user = await authRepo.autoLogin();
      userModel = user;
      isGuest = authRepo.isGuest;
      emit(AutoLoginSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(AutoLoginError(errorMessage));
    }
  }

  /// get profile data
  Future<void> getProfileData() async {
    emit(GetProfileLoading());

    try {
      userModel = await authRepo.getProfileData();
      emit(GetProfileSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(GetProfileError(errorMessage));
    }
  }

  /// update profile data
  Future<void> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? imagepath,
    int? visa,
  }) async {
    emit(UpdateProfileLoading());

    try {
      userModel = await authRepo.updateProfileData(
        name: name,
        email: email,
        address: address,
        imagepath: imagepath,
        visa: visa.toString(),
      );

      emit(UpdateProfileSuccess());
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is ApiError) {
        errorMessage = e.message;
      }
      emit(UpdateProfileError(errorMessage));
    }
  }

  /// pick image
  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      selectedImage = pickedImage.path;
      emit(PickImageSuccess());
    }
  }
}
