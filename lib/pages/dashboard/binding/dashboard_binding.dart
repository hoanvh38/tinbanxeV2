import 'package:get/get.dart';
import 'package:tinbanxe/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class DashBoardBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DashBoardController(client: AuthenticateClient()));
  }

}