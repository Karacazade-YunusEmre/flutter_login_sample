import 'package:flutter_login_sample/model/base/i_base_model.dart';

/// Created by Yunus Emre Yıldırım
/// on 18.10.2022

abstract class IAuthBaseService<T extends IBaseModel> {
  Future<String?> userRegisterWithEmailAndPassword(T model);

  Future<bool> userSignInWithEmailAndPassword(T model);

  Future<T?> userSignInWithGoogle();

  Future<T?> userSignInWithFacebook();

  Future<void> userSignOut();

  T? getCurrentUser();

  Future<bool> isUserSignIn();
}
