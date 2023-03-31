import 'package:get/get.dart';
import 'package:tinbanxe/pages/acount/change_password/controller/change_password_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController(
        client: AuthenticateClient(),
        ));
  }
}
