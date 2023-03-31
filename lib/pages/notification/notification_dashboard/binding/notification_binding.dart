import 'package:get/get.dart';
import 'package:tinbanxe/pages/notification/notification_dashboard/controller/notification_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController(
      client: AuthenticateClient(),
    ));
  }
}