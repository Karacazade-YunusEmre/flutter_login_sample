import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_sample/controller/user_controller.dart';
import 'package:flutter_login_sample/firebase_options.dart';
import 'package:flutter_login_sample/service/base/i_auth_base_service.dart';
import 'package:flutter_login_sample/service/firebase/firebase_auth_service.dart';
import 'package:flutter_login_sample/utilities/app_theme_data.dart';
import 'package:flutter_login_sample/utilities/routes.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

late IAuthBaseService userService;
late UserController userController;

Future<void> main() async {
  await initApp();
  setupLocator();
  setupController();
  runApp(const MainApp());
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void setupLocator() {
  final getIt = GetIt.instance;

  getIt.registerSingleton<IAuthBaseService>(FirebaseAuthService());

  userService = getIt<IAuthBaseService>();
}

void setupController() {
  userController = Get.put(UserController());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login Sample',
      theme: AppThemeData.getMainLightThemeData,
      getPages: Routes.getRoutes,
      initialRoute: userController.initialRoute,
    );
  }
}
