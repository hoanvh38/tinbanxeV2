import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/constants/app_constant.dart';
import 'package:tinbanxe/constants/config_constant.dart';
import 'package:tinbanxe/databases/config_db.dart';
import 'package:tinbanxe/databases/user_db.dart';
import 'package:tinbanxe/helpers/extension/email_validator.dart';
import 'package:tinbanxe/helpers/extension/validator.dart';
import 'package:tinbanxe/models/config_model.dart';
import 'package:tinbanxe/models/user_model.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/routes/app_pages.dart';
import 'package:tinbanxe/utils/dialog_util.dart';
import 'package:tinbanxe/utils/error_capture_util.dart';
import 'package:tinbanxe/utils/error_util.dart';
import 'package:tinbanxe/utils/object_util.dart';
import 'dart:core';

class ForgotPasswordController extends GetxController {
  final AuthenticateClient client;

  ForgotPasswordController({
    required this.client,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode rePasswordFocus = FocusNode();
  final FocusNode otpFocus = FocusNode();

  var loading = false.obs;
  bool hasError = false;
  var isShowPassword = false.obs;
  var isShowRePassword = false.obs;
  var emailValid = true.obs;
  var passwordValid = true.obs;
  var rePasswordValid = true.obs;
  var otpValid = true.obs;

  var emailErrorMsg = 'invalid_email'.tr.obs;
  var passErrorMsg = 'invalid_password'.tr.obs;
  var otpErrorMsg = 'invalid_otp'.tr.obs;
  var rePassError = 'invalid_otp'.tr.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    emailFocus.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    rePasswordController.dispose();
    rePasswordFocus.dispose();
    super.onClose();
  }

  onChangeText(text) {
    if (emailController.text.isEmpty) {
      emailErrorMsg.value = 'invalid_email'.tr;
    }
    emailValid.value = emailController.text.isNotEmpty;
  }

  onChangeOTP(text) {
    if (otpController.text.isEmpty) {
      otpErrorMsg.value = 'invalid_otp'.tr;
    }
    otpValid.value = otpController.text.isNotEmpty;
  }

  onChangeEmail(String email) {
    if (!emailController.text.isValidEmail()) {
      emailErrorMsg.value = 'invalid_email'.tr;
    }
    emailValid.value = emailController.text.isNotEmpty;
    ConfigDB().save(ConfigModel(CONFIG_REGISTER_USERNAME, email));
  }

  onChangePass(String text) {
    passwordValid.value = passwordController.text.isNotEmpty;
  }

  onChangeRePass(String text) {
    rePasswordValid.value = rePasswordController.text.isNotEmpty;
  }

  bool isValid() {
    return emailValid.value && emailController.text.isNotEmpty;
  }

  bool isValidBtnOtp() {
    return otpValid.value && otpController.text.isNotEmpty;
  }

  bool isValidBtnNewPass() {
    return emailValid.value &&
        emailController.text.isNotEmpty &&
        passwordValid.value &&
        passwordController.text.isNotEmpty &&
        rePasswordValid.value &&
        rePasswordController.text.isNotEmpty;
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }

  toggleShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  toggleShowRePassword() {
    isShowRePassword.value = !isShowRePassword.value;
  }

  onSubmit() async {
    if (!CheckEmailValidator.validate(emailController.text)) {
      print(CheckEmailValidator.validate(emailController.text));
      emailValid.value = false;
      emailErrorMsg.value = 'invalid_email'.tr;
      DialogUtil.showErrorMessage(emailErrorMsg.value);
      return;
    }

    if (isValid()) {
      loading.value = true;
      try {
        var response = await client.forgotPassword(emailController.text);
        if (response.statusCode == 200 && response.data['success'] == 1) {
          await DialogUtil.showSuccessMessage(response.data['message']);
          loading.value = false;
          return Get.toNamed(Routes.VERIFY_OTP);
        } else {
          DialogUtil.showErrorMessage(response.data['message']);
          loading.value = false;
        }
      } catch (error) {
        loading.value = false;
        DialogUtil.showErrorMessage("serve_error".tr);
      }
    }
  }

  onVerifyOTP() async {
    try {
      if (loading.isFalse) {
        loading.value = true;
        var response =
            await client.verifyCode(otpController.text, emailController.text);
        if (response.statusCode == 200 && response.data['success'] == 1) {
          loading.value = false;
           Get.toNamed(Routes.NEW_PASS);
        }
      }
    } catch (error) {
      loading.value = false;
      DialogUtil.showErrorMessage("serve_error".tr);
    }
  }

  onSubmitNewPass() async {
    try {
      if (!CheckEmailValidator.validate(emailController.text)) {
        emailValid.value = false;
        emailErrorMsg.value = 'invalid_email'.tr;
        DialogUtil.showErrorMessage(emailErrorMsg.value);
        return;
      }

      if (!passwordController.text.isValidPassword()) {
        passwordValid.value = false;
        passErrorMsg.value = 'invalid_password'.tr;
        DialogUtil.showErrorMessage(passErrorMsg.value);
        return;
      }
      if (!rePasswordController.text.isValidPassword()) {
        rePasswordValid.value = false;
        rePassError.value = 'invalid_password'.tr;
        DialogUtil.showErrorMessage(rePassError.value);
        return;
      }

      if (rePasswordController.text != passwordController.text) {
        rePasswordValid.value = false;
        rePassError.value = 'pass_not_true'.tr;
        DialogUtil.showErrorMessage(rePassError.value);
        return;
      }

      if(isValidBtnNewPass()){
        loading.value = true;
        var response =
          await client.changePassword(emailController.text, passwordController.text);
        if (response.statusCode == 200 && response.data['success'] == 1){
          loading.value = false;
          await DialogUtil.showSuccessMessage(response.data['message']);
           Get.offNamed(Routes.LOGIN);
        } else {
          loading.value = false;
          DialogUtil.showErrorMessage(response.data['message']);
        }
      }
    } catch (error) {
      loading.value = false;
      DialogUtil.showErrorMessage("serve_error".tr);
    }
  }
}
