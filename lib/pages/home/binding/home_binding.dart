import 'package:tinbanxe/pages/acount/acount_dashboard/controller/acount_controller.dart';
import 'package:tinbanxe/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tinbanxe/pages/home/controller/home_controller.dart';
import 'package:tinbanxe/pages/notification/notification_dashboard/binding/notification_binding.dart';
import 'package:tinbanxe/pages/notification/notification_dashboard/controller/notification_controller.dart';
import 'package:tinbanxe/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DashBoardController(client: AuthenticateClient()));
    Get.lazyPut(() => AccountController(client: AuthenticateClient()));
    Get.lazyPut(() => NotificationController(client: AuthenticateClient()));

    // Get.lazyPut(() => Ac());
    // Get.lazyPut(() => SearchController());
  }
}
