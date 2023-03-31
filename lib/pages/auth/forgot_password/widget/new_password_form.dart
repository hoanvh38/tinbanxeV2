import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/pages/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/custom_text_field.dart';

class NewPasswordFormWidget extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Obx(
                () => CustomTextField(
              width: double.infinity,
              radius: 10,
              controller: controller.passwordController,
              focusNode: controller.passwordFocus,
              labelText: 'password'.tr,
              textInputType: TextInputType.text,
              autoFillHints: [AutofillHints.email],
              errorMsg: controller.passwordValid.value
                  ? null
                  : controller.passErrorMsg.value,
              innerPadding: EdgeInsets.only(
                  top: 0.w, bottom: 0.w, left: 20.w, right: 20.w),
              outsidePadding: EdgeInsets.only(bottom: 16.w),
              onChanged: (text) {
                controller.onChangePass(text);
              },
              obscureText: !controller.isShowPassword.value,
              suffix: Icon(
                controller.isShowPassword.value
                    ? Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined,
                size: 24.w,
                color: context.textTheme.headline1!.color,
              ),
              onTabSuffix: controller.toggleShowPassword,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
                () => CustomTextField(
              labelText: 're_pass'.tr,
              width: double.infinity,
              radius: 10,
              controller: controller.rePasswordController,
              focusNode: controller.rePasswordFocus,
              textInputType: TextInputType.text,
              autoFillHints: [AutofillHints.email],
              errorMsg: controller.rePasswordValid.value
                  ? null
                  : controller.rePassError.value,
              outsidePadding: EdgeInsets.only(bottom: 40.w),
              onChanged: (text) {
                controller.onChangeRePass(text);
              },
              obscureText: !controller.isShowRePassword.value,
              suffix: Icon(
                controller.isShowRePassword.value
                    ? Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined,
                size: 24.w,
                color: context.textTheme.headline1!.color,
              ),
              onTabSuffix: controller.toggleShowRePassword,
            ),
          ),
        ],
      ),
    );
  }
}
