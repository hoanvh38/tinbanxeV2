import 'package:get/get.dart';
import 'package:tinbanxe/pages/auth/register/controller/register_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(client: AuthenticateClient()));
  }
}
