import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/pages/auth/login/controller/login_controller.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/custom_text_field.dart';

class LoginFormWidget extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Obx(() => CustomTextField(
                labelText: 'email'.tr,
                width: double.infinity,
                radius: 10,
                controller: controller.emailController,
                focusNode: controller.emailFocus,
                hintText: 'email_placeholder'.tr,
                inputFormatter: [FilteringTextInputFormatter.deny(' ')],
                textInputType: TextInputType.emailAddress,
                autoFillHints: [AutofillHints.email],
                errorMsg: controller.emailValid.value
                    ? null
                    : controller.emailErrorMsg.value,
                innerPadding: EdgeInsets.only(
                    top: 20.w, bottom: 20.w, left: 20.w, right: 20.w),
                outsidePadding: EdgeInsets.only(bottom: 10.w),
                onChanged: (text) {
                  controller.onChangeText(text);
                },
              )),
          SizedBox(
            height: 30,
          ),
          Obx(
            () => CustomTextField(
              labelText: 'password'.tr,
              width: double.infinity,
              radius: 10,
              controller: controller.passwordController,
              focusNode: controller.passwordFocus,
              obscureText: !controller.isShowPassword.value,
              autoFillHints: [AutofillHints.password],
              textInputType: TextInputType.text,
              errorMsg: controller.passwordValid.value
                  ? null
                  : controller.passErrorMsg.value,
              innerPadding: EdgeInsets.only(
                  top: 16.w, bottom: 16.w, left: 20.w, right: 20.w),
              outsidePadding: EdgeInsets.only(bottom: 16.w),
              suffix: Icon(
                controller.isShowPassword.value
                    ? Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined,
                color: context.theme.iconTheme.color!.withOpacity(0.5),
              ),
              onTabSuffix: controller.toggleShowPassword,
              onChanged: (text) {
                controller.onChangePass(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
