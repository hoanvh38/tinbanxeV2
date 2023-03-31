import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/pages/auth/register/controller/register_controller.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/custom_text_field.dart';

class RegisterFormWidget extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 20,),
          Obx(
            () => CustomTextField(
              width: double.infinity,
              radius: 10,
              controller: controller.emailController,
              focusNode: controller.emailFocus,
              labelText: 'email'.tr,
              textInputType: TextInputType.emailAddress,
              autoFillHints: [AutofillHints.email],
              inputFormatter: [FilteringTextInputFormatter.deny(' ')],
              errorMsg: controller.emailValid.value
                  ? null
                  : controller.emailErrorMsg.value,
              innerPadding: EdgeInsets.only(
                  top: 8.w, bottom: 8.w, left: 20.w, right: 20.w),
              outsidePadding: EdgeInsets.only(bottom: 16.w),
              onChanged: (text) {
                controller.onChangeEmail(text);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => CustomTextField(
              width: double.infinity,
              radius: 10,
              controller: controller.userNameController,
              focusNode: controller.userNameFocus,
              labelText: 'user_name'.tr,
              textInputType: TextInputType.text,
              autoFillHints: [AutofillHints.email],
              errorMsg: controller.userValid.value
                  ? null
                  : controller.userError.value,
              outsidePadding: EdgeInsets.only(bottom: 16.w),
              onChanged: (text) {
                controller.onChangeUserName(text);
                // controller.onChangeReferral(text);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Obx(() => Expanded(
                    child: CustomTextField(
                      width: double.infinity,
                      radius: 10,
                      controller: controller.surNameController,
                      focusNode: controller.surNameFocus,
                      labelText: 'sur_name'.tr,
                      textInputType: TextInputType.text,
                      autoFillHints: [AutofillHints.email],
                      errorMsg: controller.surNameValid.value
                          ? null
                          : controller.surError.value,
                      outsidePadding: EdgeInsets.only(bottom: 16.w),
                      onChanged: (text) {
                        controller.onChangeSurName(text);
                      },
                      onTabSuffix: controller.onScanQR,
                    ),
                  )),
              SizedBox(
                width: 16.w,
              ),
              Obx(
                () => Expanded(
                  child: CustomTextField(
                    width: double.infinity,
                    radius: 10,
                    controller: controller.nameController,
                    focusNode: controller.nameFocus,
                    labelText: 'name'.tr,
                    textInputType: TextInputType.text,
                    autoFillHints: [AutofillHints.email],
                    errorMsg: controller.nameValid.value
                        ? null
                        : controller.nameError.value,
                    outsidePadding: EdgeInsets.only(bottom: 16.w),
                    onChanged: (text) {
                      controller.onChangeName(text);
                    },
                    onTabSuffix: controller.onScanQR,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => CustomTextField(
              width: double.infinity,
              radius: 10,
              controller: controller.phoneController,
              focusNode: controller.phoneFocus,
              labelText: 'phone_number'.tr,
              textInputType: TextInputType.number,
              autoFillHints: [AutofillHints.email],
              errorMsg: controller.phoneValid.value
                  ? null
                  : controller.phoneError.value,
              outsidePadding: EdgeInsets.only(bottom: 16.w),
              onChanged: (text) {},
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => CustomTextField(
              width: double.infinity,
              radius: 10,
              controller: controller.passwordController,
              focusNode: controller.passFocus,
              labelText: 'password'.tr,
              textInputType: TextInputType.text,
              autoFillHints: [AutofillHints.email],
              errorMsg: controller.passValid.value
                  ? null
                  : controller.passError.value,
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
              focusNode: controller.rePassFocus,
              textInputType: TextInputType.text,
              autoFillHints: [AutofillHints.email],
              errorMsg: controller.rePassValid.value
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
