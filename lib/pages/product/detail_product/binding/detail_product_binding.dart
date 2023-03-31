import 'package:get/get.dart';
import 'package:tinbanxe/pages/product/detail_product/controller/detail_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class DetailCarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailCarController(client: AuthenticateClient()));
  }
}
