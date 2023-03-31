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
import 'package:tinbanxe/pages/acount/acount_dashboard/view/acount_page.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/routes/app_pages.dart';
import 'package:tinbanxe/utils/dialog_util.dart';
import 'dart:core';

class ChangePasswordController extends GetxController {
  final AuthenticateClient client;
  final user = UserModel().obs;

  ChangePasswordController({
    required this.client,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode rePasswordFocus = FocusNode();
  final FocusNode oldPasswordFocus = FocusNode();

  var loading = false.obs;
  bool hasError = false;
  var isShowPassword = false.obs;
  var isShowRePassword = false.obs;
  var emailValid = true.obs;
  var passwordValid = true.obs;
  var rePasswordValid = true.obs;

  var emailErrorMsg = 'invalid_email'.tr.obs;
  var passErrorMsg = 'invalid_password'.tr.obs;
  var rePassError = 'invalid_password'.tr.obs;

  @override
  void onInit() {
    user.value = UserDB().currentUser()!;
    emailController.text = user.value.email;
    super.onInit();
  }

  @override
  void onClose() {
    emailFocus.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    rePasswordController.dispose();
    rePasswordFocus.dispose();
    oldPasswordFocus.dispose();
    super.onClose();
  }

  onChangePass(String text) {
    passwordValid.value = passwordController.text.isNotEmpty;
  }

  onChangeRePass(String text) {
    rePasswordValid.value = rePasswordController.text.isNotEmpty;
  }

  bool isValid() {
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

  onSubmitNewPass() async {
    try {

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

      if(isValid()){
        loading.value = true;
        var response =
          await client.changePassword(emailController.text, passwordController.text);
        if (response.statusCode == 200 && response.data['success'] == 1){
          loading.value = false;
          await DialogUtil.showSuccessMessage(response.data['message']);
          return Get.to(() => AccountPage());
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
