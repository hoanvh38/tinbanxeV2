import 'dart:async';
import 'dart:convert';

import 'package:tinbanxe/constants/config_constant.dart';
import 'package:tinbanxe/databases/banner_db.dart';
import 'package:tinbanxe/databases/config_db.dart';
import 'package:tinbanxe/models/banner_model.dart';
import 'package:tinbanxe/pages/home/controller/home_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:tinbanxe/utils/dialog_util.dart';
import 'package:tinbanxe/utils/error_util.dart';
import 'package:tinbanxe/utils/object_util.dart';

class SplashController extends GetxController {
  final AuthenticateClient client;

  SplashController({required this.client});

  StreamController<DateTime>? event;
  Timer? timer;

  final listBanner = <BannerModel>[].obs;

  @override
  void onInit() {
    config();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    // configListener.cancel()
  }

  config() async {
    String? token = ConfigDB().getConfigByName(CONFIG_ACCESS_TOKEN);
    if (ObjectUtil.isNotEmpty(token)) {
      await Future.delayed(const Duration(milliseconds: 1500));
      Get.offNamed(Routes.HOME, preventDuplicates: false);
    } else {
      // timer = Timer.periodic(Duration(seconds: 20), (t) {
      await Future.delayed(const Duration(milliseconds: 3000));
      Get.offNamed(Routes.LOGIN, preventDuplicates: false);
      // });
    }
  }

}
