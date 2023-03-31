import 'package:get/get.dart';
import 'package:tinbanxe/pages/myNews/controller/my_post_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class MyPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyPostController(client: AuthenticateClient()));
  }

}