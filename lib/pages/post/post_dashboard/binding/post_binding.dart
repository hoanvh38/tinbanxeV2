import 'package:get/get.dart';
import 'package:tinbanxe/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostController(
      client: AuthenticateClient(),

    ));
  }
}