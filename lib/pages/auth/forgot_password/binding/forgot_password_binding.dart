import 'package:get/get.dart';
import 'package:tinbanxe/pages/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController(
        client: AuthenticateClient(),
        ));
  }
}
