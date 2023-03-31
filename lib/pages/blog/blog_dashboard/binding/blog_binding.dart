import 'package:get/get.dart';
import 'package:tinbanxe/pages/blog/blog_dashboard/controller/blog_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class BlogBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlogController(client: AuthenticateClient()));
  }
}
