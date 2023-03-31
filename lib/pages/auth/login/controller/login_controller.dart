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

class LoginController extends GetxController {
  final AuthenticateClient client;

  LoginController({
    required this.client,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode otpFocus = FocusNode();
  var loading = false.obs;
  var isShowPassword = false.obs;
  var emailValid = true.obs;
  var passwordValid = true.obs;
  var otpValid = true.obs;
  var emailErrorMsg = 'invalid_email'.tr.obs;
  var passErrorMsg = 'invalid_password'.tr.obs;
  var otpErrorMsg = 'invalid_otp'.tr.obs;
  var verifyTime = DateTime.now().toLocal().millisecondsSinceEpoch.obs;

  @override
  void onInit() {
    super.onInit();
    String? username = ConfigDB().getConfigByName(CONFIG_LAST_USERNAME);
    if (ObjectUtil.isNotEmpty(username)) {
      emailController.text = username!;
    } else {
      emailController.clear();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    otpController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    otpFocus.dispose();
    super.onClose();
  }

  onChangeText(String text) {
    if (emailController.text.isEmpty) {
      emailErrorMsg.value = 'invalid_email'.tr;
    }
    emailValid.value = emailController.text.isNotEmpty;

    // if (passwordController.text.isEmpty) {
    //   passErrorMsg.value = 'invalid_password'.tr;
    // }
    // passwordValid.value = passwordController.text.isNotEmpty;
  }

  onChangePass(String pass) {
    passwordValid.value = passwordController.text.isNotEmpty;
  }

  onSubmitLogin() async {
    if (!CheckEmailValidator.validate(emailController.text)) {
      print(CheckEmailValidator.validate(emailController.text));
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

    if (isValid()) {
      loading.value = true;
      await client
          .login(emailController.text, passwordController.text)
          .then((response) async {
        print(response);
        if (response.data['success'] == 1) {
          DialogUtil.showSuccessMessage('success'.tr);
          ConfigDB().deleteConfigByName(CONFIG_REGISTER_USERNAME);
          await ConfigDB().save(ConfigModel(
              CONFIG_ACCESS_TOKEN, response.data['token']));
          await ConfigDB().save(
              ConfigModel(CONFIG_USERNAME, emailController.text.toLowerCase()));
          await client.getAccountInfo().then((response) async {
            print(response);
            final user =
            await UserDB().save(UserModel.fromJson(response.data));
            print(user);
            ConfigDB().save(ConfigModel(CONFIG_LAST_USERNAME, user.email));
            configureSentryScope();
            loading.value = false;
            Get.offAllNamed(Routes.HOME);
          }).catchError((error, trace) {
            loading.value = false;
            print(error);
            print(trace);
            String? msg = ErrorUtil.getError(error, trace);
            print(msg);
          });
          loading.value = false;
          // onSendOTP();
          DialogUtil.showSuccessMessage('success'.tr);
          configureSentryScope();
          loading.value = false;
          DialogUtil.showSuccessToast('login_success'.tr);
          Get.offNamed(Routes.HOME);
        } else
          DialogUtil.showErrorMessage(response.data['message']);
        loading.value = false;
      });

    }


  }

  bool isValid() {
    return emailValid.value &&
        passwordValid.value &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  onResendOTP(bool isCountdown) async {
    if (isCountdown) {
      loading.value = true;
      await client
          .login(emailController.text, passwordController.text)
          .then((response) async {
        await ConfigDB().save(ConfigModel(
            CONFIG_ACCESS_TOKEN, response.data['data']['access_token']));
        await ConfigDB().save(
            ConfigModel(CONFIG_USERNAME, emailController.text.toLowerCase()));
        loading.value = false;
        onSendOTP();
      }).catchError((error, trace) {
        loading.value = false;
        print(error);
        print(trace);
        String? msg = ErrorUtil.getError(error, trace);
        if (ObjectUtil.isNotEmpty(msg)) {
          otpValid.value = false;
        } else {
          DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
        }
      });
      otpValid.value = true;
      otpController.text = '';
    }
  }

  onVerifyOTP() async {
    // if (loading.isFalse) {
    //   loading.value = true;
    //   if (otpController.text.isValidOTP()) {
    //     await client
    //         .confirmLoginOTP(
    //             ConfigDB().getConfigByName(CONFIG_ACCESS_TOKEN) ?? '',
    //             otpController.text)
    //         .then((response) async {
    //       await ConfigDB().save(ConfigModel(
    //           CONFIG_ACCESS_TOKEN, response.data['data']['access_token']));
    //       await client.getAccountInfo().then((response) async {
    //         final user =
    //             await UserDB().save(UserModel.fromJson(response.data['data']));
    //         ConfigDB().save(ConfigModel(CONFIG_LAST_USERNAME, user.email));
    
    //         fcmService.getFcmToken(userClient);
    //         await ConfigDB().save(ConfigModel(
    //             CONFIG_ACCOUNT_MODE,
    //             user.mode == ACCOUNT_MODE_VIRTUAL
    //                 ? ACCOUNT_MODE_VIRTUAL
    //                 : ACCOUNT_MODE_REAL));
    //         Get.offAllNamed(Routes.HOME);
    //       }).catchError((error, trace) {
    //         loading.value = false;
    //         print(error);
    //         print(trace);
    //         String? msg = ErrorUtil.getError(error, trace);
    //         print(msg);
    //       });
    //     }).catchError((error, trace) {
    //       loading.value = false;
    //       print(error);
    //       print(trace);
    //       String? msg = ErrorUtil.getError(error, trace);
    //       if (ObjectUtil.isNotEmpty(msg)) {
    //         otpErrorMsg.value = msg!.tr;
    //         otpValid.value = false;
    //         DialogUtil.showErrorMessage(otpErrorMsg.value);
    //         otpController.text = '';
    //         return;
    //       } else {
    //         DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
    //         otpController.text = '';
    //       }
    //     });
    //   } else {
    //     loading.value = false;
    //     otpValid.value = false;
    //     otpErrorMsg.value = 'CONFIRM_CODE_NOT_VALID'.tr;
    //     DialogUtil.showErrorMessage(otpErrorMsg.value);
    //     otpController.text = '';
    //     return;
    //   }
    // }
  }

  onBack() {
    Get.back();
  }

  onSendOTP() {
    verifyTime.value =
        DateTime.now().toLocal().millisecondsSinceEpoch + 1000 * RESEND_OTP;
  }

  onForgotPass() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  onGoToRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }

  toggleShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }
}
