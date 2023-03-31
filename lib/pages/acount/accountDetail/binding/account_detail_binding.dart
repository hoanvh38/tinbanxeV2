import 'package:get/get.dart';
import 'package:tinbanxe/pages/acount/accountDetail/controller/account_detail_controller.dart';

class AccountDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountDetailController());
  }

}