import 'dart:core';

import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utiles/pref_helpers.dart';
import 'package:hungry/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGuest = false;
  UserModel? _currentUser;

  // login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post("/login", {
        "email": email,
        "password": password,
      });

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final data = response["data"];
        final code = response["code"];
        final int coder = code is int
            ? code
            : int.tryParse(code?.toString() ?? '') ?? 0;
        final msg = response["message"];

        if (coder != 200 || data == null) {
          throw ApiError(message: msg);
        }
        final user = UserModel.fromJson(response["data"]);
        if (user.token != null) {
          await PrefHelpers.setToken(user.token!);
        }
        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: "UnExpected Error Form Server");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // sign up
  Future<UserModel?> signup(String name, String email, String password) async {
    final response = await apiService.post("/register", {
      "name": name,
      "email": email,
      "password": password,
    });
    if (response is ApiError) {
      throw response;
    }
    // -------  condition assement  ---------
    if (response is Map<String, dynamic>) {
      final data = response["data"];
      final code = response["code"];
      final int coder = code is int
          ? code
          : int.tryParse(code?.toString() ?? '') ?? 0;
      String msg = response["message"]?.toString() ?? "Something went wrong";
      if (response["message"] != null) {
        msg = response["message"].toString();
      }
      if (response["errors"] != null &&
          response["errors"]["email"] is List &&
          (response["errors"]["email"] as List).isNotEmpty) {
        msg = response["errors"]["email"][0].toString();
      }
      if ((coder != 200 && coder != 201) || data == null) {
        throw ApiError(message: msg);
      }
      final user = UserModel.fromJson(response["data"]);
      if (user.token != null) {
        await PrefHelpers.setToken(user.token!);
      }
      isGuest = false;
      _currentUser = user;
      return user;
    }
    // -------  condition assement  ---------
    else {
      throw ApiError(message: "UnExpected Error Form Server");
    }
  }

  //Get Profile data

  Future<UserModel?> getProfileData() async {
    try {
      final token = await PrefHelpers.getToken();
      if (token == null || token == "guest") {
        return null;
      }

      final response = await apiService.Get("/profile");
      final user = UserModel.fromJson(response["data"]);
      _currentUser = user;
      return user;

      // if (response is ApiError) {
      //   throw response;
      // }

      // if (response is Map<String, dynamic>) {
      //   final data = response["data"];
      //   if (data is Map<String, dynamic>) {
      //     return UserModel.fromJson(data);
      //   }
      // }
      // throw ApiError(message: "Unexpected response from server");
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //Update Profile data
  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? imagepath,
    bool removeImage = false,
    String? visa,
    bool removeVisa = false,
  }) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "email": email,
        "address": address,
        if (imagepath != null && imagepath.isNotEmpty)
          "image": await MultipartFile.fromFile(
            imagepath,
            filename: "imageprofile.jpg",
          ),
        if (visa != null && visa.isNotEmpty) "Visa": visa,
      });

      final response = await apiService.post("/update-profile", formData);
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final data = response["data"];
        final code = response["code"];
        final int coder = code is int
            ? code
            : int.tryParse(code?.toString() ?? '') ?? 0;
        String msg = response["message"]?.toString() ?? "Something went wrong";
        if (response["message"] != null) {
          msg = response["message"].toString();
        }
        if (response["errors"] != null &&
            response["errors"]["email"] is List &&
            (response["errors"]["email"] as List).isNotEmpty) {
          msg = response["errors"]["email"][0].toString();
        }
        if ((coder != 200 && coder != 201) || data == null) {
          throw ApiError(message: msg);
        }
        final UpdateUser = UserModel.fromJson(response["data"]);
        _currentUser = UpdateUser;
        return UpdateUser;
      }
      return null;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // logout
  Future<UserModel?> logout() async {
    final response = await apiService.post("/logout", {});
    if (response["data"] != null) {
      throw ApiError(message: "UnExpected Error Form Server");
    }
    await PrefHelpers.clearToken();
    isGuest = true;
    _currentUser = null;
    return null;
  }

  //auto login
  Future<UserModel?> autoLogin() async {
    final token = await PrefHelpers.getToken();
    if (token == null || token == "guest") {
      isGuest = true;
      _currentUser = null;
      return null;
    }
    isGuest = false;
    try {
      final user = await getProfileData();
      _currentUser = user;
      return user;
    } catch (e) {
      await PrefHelpers.clearToken();
      isGuest = true;
      _currentUser = null;
      return null;
    }
  }

  //continue as guest
  Future<void> continueAsGuest() async {
    isGuest = true;
    _currentUser = null;
    await PrefHelpers.setToken("guest");
  }

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => !isGuest && _currentUser != null;
}
