import 'package:flutter/material.dart';
import 'package:tinbanxe/pages/auth/register/controller/register_controller.dart';
import 'package:tinbanxe/pages/auth/register/widget/register_form.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/_default_header.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/widgets/_radius_button.dart';
import 'package:tinbanxe/widgets/custom/customAppBar/custom_app_bar.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          // bottomNavigationBar: Container(color: context.theme.ac,),
          backgroundColor: context.theme.backgroundColor,
          appBar: CustomAppBar(),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLogo(context),
                          SizedBox(
                            height: 12.w,
                          ),
                          DefaultHeader(
                            padding: EdgeInsets.only(bottom: 12.w),
                            title: 'register_note'.tr,
                            description: 'register_content'.tr,
                          ),
                          RegisterFormWidget(),
                        ],
                      ),
                    ),
                  ),
                  buildFooter(context),
                ],
              ),
            ),
            onTap: controller.resetFocus,
          ),
        ),
      ),
    );
  }

  Widget buildFooter(BuildContext context) {
    return Obx(
      () => RadiusButton(
        isFullWidth: true,
        isDisable: !controller.isValid(),
        maxWidth: double.infinity,
        radius: 24.w,
        outsidePadding: EdgeInsets.only(
          top: 23.w,
          bottom: 35.w,
        ),
        innerPadding: controller.loading.value
            ? EdgeInsets.only(top: 14.w, bottom: 14.w, left: 20.w, right: 20.w)
            : EdgeInsets.only(
                top: 16.w,
                bottom: 16.w,
                left: 5.w,
                right: 5.w,
              ),
        isLoading: controller.loading.value,
        indicatorSize: 24.w,
        text: 'register'.tr,
        fontFamily: Style.fontDemiBold,
        fontSize: 17.sp,
        backgroundColor: context.theme.primaryColor,
        textColor: context.textTheme.button!.color,
        onTap: controller.onSubmit,
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        AppSetting.imgLogo,
        width: 150.w,
      ),
    );
  }

  Widget _buildRegister(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'haven_acc'.tr,
                style: Style()
                    .bodyStyle1
                    .copyWith(color: context.theme.backgroundColor),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.back();
              },
              child: Container(
                child: Text(
                  'login_now'.tr,
                  style: Style()
                      .bodyStyle2
                      .copyWith(color: context.theme.backgroundColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
