import 'package:flutter/material.dart';
import 'package:flutter_login_sample/main.dart';
import 'package:flutter_login_sample/model/base/i_base_model.dart';
import 'package:flutter_login_sample/model/concrete/user_model.dart';
import 'package:get/get.dart';

/// Created by Yunus Emre Yıldırım
/// on 18.10.2022

class UserController extends GetxController {
  final userList = <UserModel>[].obs;
  final _initialRoute = '/'.obs;

  @override
  void onInit() async {
    super.onInit();

    await _isUserSignIn();
  }

  ///#region getter and setter

  /// initial route getter
  String get initialRoute => _initialRoute.value;

  /// initial route setter
  set initialRoute(String value) => _initialRoute.value = value;

  ///#endregion getter and setter

  ///#region user event methods

  UserModel? getCurrentUser() {
    try {
      IBaseModel? user = userService.getCurrentUser();
      if (user != null) {
        return user as UserModel;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('getCurrentUser HATA!: ${e.toString()}');
      return null;
    }
  }

  Future<void> _isUserSignIn() async {
    bool userState = await userService.isUserSignIn();
    if (userState) {
      debugPrint('User signed in from UserController');
    } else {
      initialRoute = '/login_page';
    }
  }

  Future<bool> userRegisterWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserModel userModel = UserModel.withoutId(email: email, password: password);
      String? userId = await userService.userRegisterWithEmailAndPassword(userModel);
      userModel.id = userId;

      userList.add(userModel);
      return true;
    } catch (e) {
      debugPrint('Kullanıcı ekleme işlemi sırasında hata oluştu. ${e.toString()}');
      return false;
    }
  }

  Future<bool> userLogInWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserModel userModel = UserModel.withoutId(email: email, password: password);
      final result = await userService.userSignInWithEmailAndPassword(userModel);
      if (result) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Kullanıcı oturum açma işlemi sırasında hata oluştu! ${e.toString()}');
      return false;
    }
  }

  Future<bool> userLogInWithGoogle() async {
    try {
      IBaseModel? userModel = await userService.userSignInWithGoogle();

      if (userModel == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      debugPrint('Google ile giriş işlemi sırasında hata oluştu. ${e.toString()}');
      return false;
    }
  }

  Future<bool> userLogInWithFacebook() async {
    try {
      IBaseModel? userModel = await userService.userSignInWithFacebook();
      if (userModel != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Facebook ile giriş işlemi sırasında hata oluştu. ${e.toString()}');
      return false;
    }
  }

  Future<bool> userLogOut() async {
    try {
      await userService.userSignOut();
      return true;
    } catch (e) {
      debugPrint('Kullanıcı çıkış işlemi sırasında hata oluştu. ${e.toString()}');
      return false;
    }
  }

  ///#endregion user event methods
}
