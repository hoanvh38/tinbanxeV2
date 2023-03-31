import 'package:get/get.dart';
import 'package:tinbanxe/databases/user_db.dart';
import 'package:tinbanxe/models/user_model.dart';

class AccountDetailController extends GetxController {
  final user = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    user.value = UserDB().currentUser() ?? UserModel();
  }
}