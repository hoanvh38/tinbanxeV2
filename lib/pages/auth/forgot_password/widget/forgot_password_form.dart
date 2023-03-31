import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/pages/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/custom_text_field.dart';

class ForgotPasswordFormWidget extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Obx(
            () => CustomTextField(
              labelText: 'email'.tr,
              width: double.infinity,
              radius: 10,
              controller: controller.emailController,
              focusNode: controller.emailFocus,
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
            ),
          ),
        ],
      ),
    );
  }
}
