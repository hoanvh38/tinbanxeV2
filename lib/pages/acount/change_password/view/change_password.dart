import 'package:flutter/material.dart';
import 'package:tinbanxe/pages/acount/change_password/controller/change_password_controller.dart';
import 'package:tinbanxe/pages/acount/change_password/widget/change_password_form.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/_default_header.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/widgets/_radius_button.dart';
import 'package:tinbanxe/widgets/custom/customAppBar/custom_app_bar.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: 'change_pass'.tr,
            centerTitle: true,
          ),
          resizeToAvoidBottomInset: true,
          // bottomNavigationBar: Container(color: context.theme.ac,),
          backgroundColor: context.theme.backgroundColor,
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
                          ChangePasswordFormWidget(),
                          buildFooter(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: controller.resetFocus,
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        AppSetting.imgLogo,
        width: 150.w,
        height: 150.w,
      ),
    );
  }

  Widget buildFooter(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      SizedBox(height: 16.w),
      Obx(
        () => RadiusButton(
          isFullWidth: true,
          isDisable: !controller.isValid(),
          maxWidth: double.infinity,
          radius: 24.w,
          outsidePadding: EdgeInsets.only(
            top: 23.w,
            bottom: 20.w,
          ),
          innerPadding: controller.loading.value
              ? EdgeInsets.only(
                  top: 14.w, bottom: 14.w, left: 20.w, right: 20.w)
              : EdgeInsets.only(
                  top: 16.w,
                  bottom: 16.w,
                  left: 5.w,
                  right: 5.w,
                ),
          isLoading: controller.loading.value,
          indicatorSize: 24.w,
          text: 'btn_change_pass'.tr,
          fontFamily: Style.fontDemiBold,
          fontSize: 17.sp,
          backgroundColor: context.theme.primaryColor,
          textColor: context.textTheme.button!.color,
          onTap: controller.onSubmitNewPass,
        ),
      ),
    ]);
  }
}
