import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_login_sample/controller/user_controller.dart';
import 'package:flutter_login_sample/utilities/app_theme_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

/// Created by Yunus Emre Yıldırım
/// on 18.10.2022

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserController userController;

  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  void initState() {
    super.initState();

    userController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'KARACAZADE',
      logo: const AssetImage('assets/images/flutter_logo.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      hideForgotPasswordButton: true,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () => Get.offAndToNamed('/'),
      loginAfterSignUp: true,
      userValidator: _userValidator,
      passwordValidator: _passwordValidator,
      messages: AppThemeData.getLoginMessages,
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            bool result = await Future.delayed(loginTime).then((_) => userController.userLogInWithGoogle());
            if (result) {
              return null;
            } else {
              return 'Google ile giriş sırasında hata oluştu';
            }
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          label: 'Facebook',
          callback: () async {
            bool result = await Future.delayed(loginTime).then((_) => userController.userLogInWithFacebook());
            if (result) {
              return null;
            } else {
              return 'Facebook ile giriş sırasında hata oluştu!';
            }
          },
        ),
      ],
    );
  }

  Future<String?> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      bool result = await userController.userLogInWithEmailAndPassword(email: data.name, password: data.password);
      if (result) {
        return null;
      } else {
        return 'Kullanıcı geçerli değil!';
      }
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) async {
      final result = await userController.userRegisterWithEmailAndPassword(email: data.name!, password: data.password!);
      if (result) {
        return null;
      } else {
        return 'Kullanıcı ekleme işlemi sırasında hata oluştu!';
      }
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      //   return 'Kullanıcı bulunamadı!';
      // }
      return null;
    });
  }

  String? _userValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (EmailValidator.validate(value)) {
        return null;
      } else {
        return 'Email adresi geçerli değil!';
      }
    } else {
      return 'Email alanı boş olamaz!';
    }
  }

  String? _passwordValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length <= 5) {
        return 'Parola 6 karakterden az olamaz!';
      } else {
        return null;
      }
    } else {
      return 'Parola alanı boş olamaz!';
    }
  }
}
