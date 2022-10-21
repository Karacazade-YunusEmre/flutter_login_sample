import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_sample/model/concrete/user_model.dart';
import 'package:flutter_login_sample/service/base/i_auth_base_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Created by Yunus Emre Yıldırım
/// on 18.10.2022

class FirebaseAuthService implements IAuthBaseService<UserModel> {
  late FirebaseAuth firebaseAuth;

  FirebaseAuthService() {
    firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Future<String?> userRegisterWithEmailAndPassword(UserModel model) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: model.email, password: model.password!);
      return userCredential.user?.uid;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> userSignInWithEmailAndPassword(UserModel model) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: model.email, password: model.password!);
      if (userCredential.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> userSignOut() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        await firebaseAuth.signOut();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  UserModel? getCurrentUser() {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        UserModel currentUser = UserModel.withoutPassword(id: user.uid, email: user.email!);
        return currentUser;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> isUserSignIn() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<UserModel?> userSignInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      UserModel userModel = UserModel.withoutPassword(id: userCredential.user!.uid, email: userCredential.user!.email!);
      return userModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel?> userSignInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      UserModel userModel = UserModel.withoutPassword(id: userCredential.user!.uid, email: userCredential.user!.email!);
      return userModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
