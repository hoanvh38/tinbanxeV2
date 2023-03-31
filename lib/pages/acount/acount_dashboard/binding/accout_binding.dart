import 'package:tinbanxe/pages/acount/acount_dashboard/controller/acount_controller.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController(client: AuthenticateClient()));
  }
}