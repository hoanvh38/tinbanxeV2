import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tinbanxe/pages/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:tinbanxe/pages/auth/forgot_password/widget/forgot_password_form.dart';
import 'package:tinbanxe/pages/auth/forgot_password/widget/verify_form.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/_default_header.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/widgets/_radius_button.dart';
import 'package:tinbanxe/widgets/custom/customAppBar/custom_app_bar.dart';
import 'package:tinbanxe/widgets/custom_text_field.dart';

class VerifyOTP extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            appBar: CustomAppBar(),
            resizeToAvoidBottomInset: false,
            backgroundColor: context.theme.backgroundColor,
            body: GestureDetector(
              onTap: controller.resetFocus,
              child: Stack(
                children: [
                  Positioned(
                    top: 0.w,
                    right: 0.w,
                    left: 0.w,
                    bottom: 80.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: context.theme.backgroundColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.w),
                            bottomRight: Radius.circular(50.w)),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLogo(context),
                              DefaultHeader(
                                padding:
                                    EdgeInsets.only(top: 5.w, bottom: 32.w),
                                title: 'verification'.tr,
                                description: "verification_desc".tr,
                              ),
                              VerifyFormWidget(),
                              buildFooter(context),
                            ],
                          ),
                        ),
                      ),
                      // onTap: controller.resetFocus,
                    ),
                  ),
                ],
              ),
            )),
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
          isDisable: !controller.isValidBtnOtp(),
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
          text: 'btn_verify'.tr,
          fontFamily: Style.fontDemiBold,
          fontSize: 17.sp,
          backgroundColor: context.theme.primaryColor,
          textColor: context.textTheme.button!.color,
          onTap: controller.onVerifyOTP
        ),
      ),
    ]);
  }
}
