import 'package:tinbanxe/constants/app_constant.dart';
import 'package:tinbanxe/pages/splash/controller/splash_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/utils/screen_util.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tinbanxe/helpers/responsive.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: BASE_WIDTH, allowFontScaling: true)
      ..init(context);

    FlutterError.onError =
        (FlutterErrorDetails details, {bool forceReport = false}) {
      FlutterError.dumpErrorToConsole(details, forceReport: true);
    };

    return GetBuilder<SplashController>(
        init: SplashController(client: AuthenticateClient()),
        builder: (splashController) {
          return Material(
            color: context.theme.backgroundColor,
            child: SafeArea(
              bottom: false,
              child: Scaffold(
                backgroundColor: context.theme.backgroundColor,
                body: Container(
                  alignment: Alignment.center,
                  child: Lottie.asset(
                    AppSetting.lottieSplash,
                    width: 300.w,
                    height: 300.w,
                    fit: BoxFit.scaleDown,
                    repeat: true,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
