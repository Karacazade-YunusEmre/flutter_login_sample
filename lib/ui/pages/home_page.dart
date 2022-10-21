import 'package:flutter/material.dart';
import 'package:flutter_login_sample/controller/user_controller.dart';
import 'package:flutter_login_sample/model/concrete/user_model.dart';
import 'package:get/get.dart';

/// Created by Yunus Emre Yıldırım
/// on 18.10.2022

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserController userController;
  late UserModel? currentUser;

  @override
  void initState() {
    super.initState();

    userController = Get.find();
    currentUser = userController.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Login'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final result = await userController.userLogOut();
                if (result) {
                  Get.offAndToNamed('/login_page');
                } else {
                  Get.snackbar('HATA', 'Çıkış işlemi sırasında hata oluştu!');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.black,
              ),
              child: const Text('Çıkış Yap'),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Giriş yapan kullanıcı: ${currentUser!.email}'),
            ),
          ],
        ),
      ),
    );
  }
}
