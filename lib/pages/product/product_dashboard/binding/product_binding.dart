import 'package:tinbanxe/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';

class ProductBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController(client: AuthenticateClient()));
  }

}