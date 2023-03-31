import 'package:get/get.dart';
import 'package:tinbanxe/pages/auth/login/controller/login_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
        client: AuthenticateClient(),
        ));
  }
}
