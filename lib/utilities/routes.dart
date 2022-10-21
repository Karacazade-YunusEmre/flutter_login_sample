
import 'package:flutter_login_sample/ui/pages/home_page.dart';
import 'package:flutter_login_sample/ui/pages/login_page.dart';
import 'package:get/get.dart';

/// Created by Yunus Emre Yıldırım
/// on 18.10.2022

const transitionDuration = Duration(milliseconds: 375);

class Routes {
  static List<GetPage> get getRoutes {
    return <GetPage>[
      GetPage(
        name: '/login_page',
        page: () => const LoginPage(),
        transitionDuration: transitionDuration,
        transition: Transition.leftToRightWithFade,
      ),
      GetPage(
        name: '/',
        page: () => const HomePage(),
        transitionDuration: transitionDuration,
        transition: Transition.leftToRightWithFade,
      ),
    ];
  }
}
