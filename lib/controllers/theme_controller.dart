import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/constants/config_constant.dart';
import 'package:tinbanxe/databases/config_db.dart';
import 'package:tinbanxe/models/config_model.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
// import 'package:tinbanxe/constants/config_constant.dart';
// import 'package:tinbanxe/databases/config_db.dart';
// import 'package:tinbanxe/models/config_model.dart';
// import 'package:tinbanxe/repositories/user_client.dart';

class ThemeController extends GetxController {
  final AuthenticateClient client;

  ThemeController({required this.client});

  static ThemeController get to => Get.find();

  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
    _themeMode = themeMode;
    update();
    print(themeMode);
    await ConfigDB()
        .save(ConfigModel(CONFIG_THEME_MODE, getThemeString(themeMode)));
  }

  getThemeMode() async {
    ThemeMode themeMode;
    final String? themeText = ConfigDB().getConfigByName(CONFIG_THEME_MODE);
    try {
      themeMode =
          ThemeMode.values.firstWhere((e) => getThemeString(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    _themeMode = themeMode;
    await setThemeMode(themeMode);
  }

  String getThemeString(ThemeMode themeMode) {
    return themeMode.toString().split('.')[1];
  }
}
