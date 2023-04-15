import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:instagram_redesign/models/user_model.dart';
import 'package:instagram_redesign/repositories/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final userName = TextEditingController();
  final userRepo = Get.put(UserRepository());
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }
}
