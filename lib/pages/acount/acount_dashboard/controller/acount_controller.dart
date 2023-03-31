import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/constants/config_constant.dart';
import 'package:tinbanxe/databases/config_db.dart';
import 'package:tinbanxe/databases/user_db.dart';
import 'package:tinbanxe/models/user_model.dart';
import 'package:tinbanxe/pages/acount/acount_dashboard/model/static_url_model.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/routes/app_pages.dart';
import 'package:tinbanxe/utils/dialog_util.dart';
import 'package:tinbanxe/utils/error_util.dart';
import 'package:tinbanxe/utils/object_util.dart';

class AccountController extends GetxController {
  final AuthenticateClient client;


  AccountController({required this.client});

  final loading = false.obs;
  final user = UserModel().obs;

  @override
  void onInit() {

    super.onInit();
  }
  onGotoProfile() {
    Get.toNamed(Routes.PROFILE);
  }
  onGotoMyPost() {
    Get.toNamed(Routes.MyPostView);
  }
  onGotoChangePassword() {
    Get.toNamed(Routes.CHANGE_PASS);
  }
  handleLogout() async {
      Get.offAllNamed(Routes.LOGIN);
      await ConfigDB().deleteConfigByName(CONFIG_USERNAME);
      await ConfigDB().deleteConfigByName(CONFIG_ACCESS_TOKEN);
      await ConfigDB().deleteConfigByName(CONFIG_ACCOUNT_MODE);

      await ConfigDB().deleteConfigByName(CONFIG_LAST_CHART_TYPE);
      await ConfigDB().deleteConfigByName(CONFIG_LAST_ORDER_TYPE);
      await ConfigDB().deleteConfigByName(CONFIG_REGISTER_USERNAME);

      await UserDB().clear();

  }


}