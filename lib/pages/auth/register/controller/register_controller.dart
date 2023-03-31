import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/constants/app_constant.dart';
import 'package:tinbanxe/constants/config_constant.dart';
import 'package:tinbanxe/databases/config_db.dart';
import 'package:tinbanxe/helpers/extension/email_validator.dart';
import 'package:tinbanxe/helpers/extension/validator.dart';
import 'package:tinbanxe/models/config_model.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/routes/app_pages.dart';
import 'package:tinbanxe/utils/dialog_util.dart';

class RegisterController extends GetxController {
  final AuthenticateClient client;

  RegisterController({required this.client});

  final ExpandableController expandableController = ExpandableController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController surNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode userNameFocus = FocusNode();
  final FocusNode surNameFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode rePassFocus = FocusNode();
  final FocusNode otpFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  var loading = false.obs;
  var isShowPassword = false.obs;
  var isShowRePassword = false.obs;
  var emailValid = true.obs;
  var userValid = true.obs;
  var surNameValid = true.obs;
  var nameValid = true.obs;
  var phoneValid = true.obs;
  var passValid = true.obs;
  var rePassValid = true.obs;
  var emailErrorMsg = 'invalid_email'.tr.obs;
  var userError = 'invalid_email'.tr.obs;
  var surError = 'invalid_email'.tr.obs;
  var nameError = 'invalid_email'.tr.obs;
  var phoneError = 'invalid_email'.tr.obs;
  var passError = 'invalid_email'.tr.obs;
  var rePassError = 'invalid_email'.tr.obs;

  var verifyTime = DateTime
      .now()
      .toLocal()
      .millisecondsSinceEpoch
      .obs;
  TapGestureRecognizer? privacyRecognizer;
  TapGestureRecognizer? termsRecognizer;

  @override
  void onInit() {
    // expandableController.toggle()
    emailController.text =
        ConfigDB().getConfigByName(CONFIG_REGISTER_USERNAME) ?? '';
    super.onInit();
  }

  @override
  void onClose() {
    expandableController.dispose();
    emailController.dispose();
    userNameController.dispose();
    surNameController.dispose();
    nameController.dispose();
    phoneController.dispose();
    rePasswordController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    userNameFocus.dispose();
    surNameFocus.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    rePassFocus.dispose();
    super.onClose();
  }

  initDeeplinkRef() {
    // String? refCode = ConfigDB().getConfigByName(CONFIG_REF_CODE_DEEPLINK);
    // if (ObjectUtil.isNotEmpty(refCode)) {
    //   expandableController.toggle();
    //   referralController.text = refCode ?? '';
    // }
  }

  openPrivacy() {
    // launch(LINK_PRIVACY_POLICY);
  }

  openTerms() {
    // launch(LINK_TERM_OF_USE);
  }

  onChangeEmail(String email) {
    if (!emailController.text.isValidEmail()) {
      emailErrorMsg.value = 'invalid_email'.tr;
    }
    emailValid.value = emailController.text.isNotEmpty;
    ConfigDB().save(ConfigModel(CONFIG_REGISTER_USERNAME, email));
  }

  onChangePass(String text) {
    passValid.value = passwordController.text.isNotEmpty;
  }

  onChangeUserName(String text) {
    userValid.value = userNameController.text.isNotEmpty;
  }

  onChangeSurName(String text) {
    surNameValid.value = surNameController.text.isNotEmpty;
  }

  onChangeName(String text) {
    nameValid.value = nameController.text.isNotEmpty;
  }

  onChangePhone(String text) {
    phoneValid.value = phoneController.text.isNotEmpty;
  }

  onChangeRePass(String text) {
    rePassValid.value = rePasswordController.text.isNotEmpty;
  }

  onSubmit() async {
    if (!CheckEmailValidator.validate(emailController.text)) {
      emailValid.value = false;
      emailErrorMsg.value = 'invalid_email'.tr;
      DialogUtil.showErrorMessage(emailErrorMsg.value);
      return;
    }
    //

    if (!userNameController.text.isValidName()) {
      userValid.value = false;
      userError.value = 'invalid_name'.tr;
      DialogUtil.showErrorMessage(userError.value);
      return;
    }
    if (!nameController.text.isValidName()) {
      nameValid.value = false;
      nameError.value = 'invalid_name'.tr;
      DialogUtil.showErrorMessage(nameError.value);
      return;
    }
    if (!surNameController.text.isValidName()) {
      surNameValid.value = false;
      surError.value = 'invalid_name'.tr;
      DialogUtil.showErrorMessage(surError.value);
      return;
    }

    if (!passwordController.text.isValidPassword()) {
      passValid.value = false;
      passError.value = 'invalid_password'.tr;
      DialogUtil.showErrorMessage(passError.value);
      return;
    }
    if (!rePasswordController.text.isValidPassword()) {
      rePassValid.value = false;
      rePassError.value = 'invalid_password'.tr;
      DialogUtil.showErrorMessage(rePassError.value);
      return;
    }

    if (rePasswordController.text != passwordController.text) {
      rePassValid.value = false;
      rePassError.value = 'pass_not_true'.tr;
      DialogUtil.showErrorMessage(rePassError.value);
      return;
    }

    final data = {
      "email" : emailController.text,
      "password" :passwordController.text,
      "u_name" : userNameController.text,
      "f_name" : surNameController.text,
      "l_name" : nameController.text,
      "phone" :  phoneController.text
    };

    if (isValid()) {
      loading.value = true;
      await client
          .register(data)
          .then((response) async {
        print(response);
        if (response.data['success'] == 1) {
          DialogUtil.showSuccessMessage('Thanh cong'.tr);
          ConfigDB().deleteConfigByName(CONFIG_REGISTER_USERNAME);
          await ConfigDB().save(ConfigModel(
              CONFIG_ACCESS_TOKEN, response.data['token']));
          await ConfigDB().save(
              ConfigModel(CONFIG_USERNAME, emailController.text.toLowerCase()));
          ConfigDB().save(ConfigModel(CONFIG_LAST_USERNAME, emailController.text));
          loading.value = false;
          DialogUtil.showSuccessToast('register_success'.tr);
          Get.offNamed(Routes.HOME);
        } else
          DialogUtil.showErrorMessage(response.data['message']);
        loading.value = false;
      });

    }
  }

  onGoToLogin() {
    Get.back();
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }

  onBack() {
    Get.back();
  }

  onSendOTP() {
    verifyTime.value =
        DateTime
            .now()
            .toLocal()
            .millisecondsSinceEpoch + 1000 * RESEND_OTP;
  }

  onResendOTP(bool isCountdown) async {
    // if (isCountdown) {
    //   loading.value = true;
    //   await client
    //       .preRegister(emailController.text.toLowerCase(),
    //           referralCode: referralController.text)
    //       .then((response) async {
    //     loading.value = false;
    //     onSendOTP();
    //     // ignore: invalid_return_type_for_catch_error
    //   }).catchError(ErrorUtil.catchError);
    //   loading.value = false;
    //   otpValid.value = true;
    //   otpController.text = '';
    // }
  }

  onVerifyOTP() async {
    // if (loading.isFalse) {
    //   loading.value = true;
    //   if (otpController.text.isValidOTP()) {
    //     await client
    //         .confirmRegisterOTP(
    //             emailController.text.toLowerCase(), otpController.text)
    //         .then((response) async {
    //       loading.value = false;
    //       otpValid.value = true;
    //       passValid.value = true;
    //       isChecked.value = false;
    //       Get.toNamed(Routes.CREATE_PASS);
    //     }).catchError((error, trace) {
    //       loading.value = false;
    //       print(error);
    //       print(trace);
    //       String? msg = ErrorUtil.getError(error, trace);
    //
    //       if (ObjectUtil.isNotEmpty(msg)) {
    //         DialogUtil.showErrorMessage(otpErrorMsg.value);
    //         otpErrorMsg.value = msg!.tr;
    //         otpValid.value = false;
    //         otpController.text = '';
    //         return;
    //       } else {
    //         DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
    //       }
    //     });
    //   } else {
    //     loading.value = false;
    //     otpValid.value = false;
    //     otpErrorMsg.value = 'CONFIRM_CODE_NOT_VALID'.tr;
    //     DialogUtil.showErrorMessage(otpErrorMsg.value);
    //     return;
    //   }
    // }
  }

  onSubmitRegister() {
    // if (!policyValid.value || !isChecked.value) {
    //   policyValid.value = false;
    //   policyErrorMsg.value = 'invalid_check_term'.tr;
    //   DialogUtil.showErrorMessage(policyErrorMsg.value);
    //   return;
    // }
    //
    // loading.value = true;
    // resetFocus();
    // if (isValidatePass() && isChecked.value) {
    //   client
    //       .register(otpController.text, emailController.text.toLowerCase(),
    //           passwordController.text,
    //           referralCode: referralController.text)
    //       .then((response) async {
    //     ConfigDB().deleteConfigByName(CONFIG_REF_CODE_DEEPLINK);
    //     ConfigDB().deleteConfigByName(CONFIG_REGISTER_USERNAME);
    //     await ConfigDB().save(ConfigModel(
    //         CONFIG_ACCESS_TOKEN, response.data['data']['access_token']));
    //     await client.getAccountInfo().then((response) async {
    //       final user =
    //           await UserDB().save(UserModel.fromJson(response.data['data']));
    //       ConfigDB().save(ConfigModel(CONFIG_LAST_USERNAME, user.email));
    //       loading.value = false;
    //       DialogUtil.showSuccessToast('register_success'.tr);
    //       fcmService.getFcmToken(userClient);
    //       TrackingService.buildSignupEvent(referralController.text);
    //       Get.offAllNamed(Routes.HOME);
    //     }).catchError((error, trace) {
    //       ErrorUtil.catchError(error, trace);
    //     });
    //   }).catchError((error, trace) {
    //     loading.value = false;
    //     print(error);
    //     print(trace);
    //     String? msg = ErrorUtil.getError(error, trace);
    //     if (ObjectUtil.isNotEmpty(msg)) {
    //       if (msg == 'CONFIRM_CODE_NOT_VALID') {
    //         otpValid.value = false;
    //         otpErrorMsg.value = 'invalid_otp'.tr;
    //         DialogUtil.showErrorMessage('invalid_otp'.tr);
    //       } else if (msg == 'INVALID_PASSWORD') {
    //         passValid.value = false;
    //         DialogUtil.showErrorMessage('invalid_password'.tr);
    //       } else {
    //         passErrorMsg.value = msg!.tr;
    //         passValid.value = false;
    //         DialogUtil.showErrorMessage(msg.tr);
    //       }
    //     } else {
    //       DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
    //     }
    //   });
    // } else {
    //   loading.value = false;
    //   if (!passValid.value || passwordController.text.isEmpty) {
    //     passValid.value = false;
    //   } else {
    //     policyValid.value = false;
    //     policyErrorMsg.value = 'invalid_check_term'.tr;
    //   }
    // }
  }

  onScanQR() async {
    // String? result = await Get.to(
    //   () => CustomScanView(
    //     helpWidget: Container(
    //       color: Style.transparent,
    //       child: PaddingText(
    //         padding: EdgeInsets.all(
    //           20.w,
    //         ),
    //         text: 'qr_camera_note'.tr,
    //         fontFamily: Style.fontBold,
    //         fontSize: 14.sp,
    //         wordSpacing: 2.w,
    //         color: Style.shareTitleColor,
    //       ),
    //     ),
    //   ),
    // );
    //
    // if (ObjectUtil.isNotEmpty(result)) {
    //   List<String> url = result!.split('ref=');
    //   if (ObjectUtil.isNotEmpty(url) &&
    //       url.length == 2 &&
    //       url[1].isValidReferralCode()) {
    //     referralController.text = url[1];
    //   } else {
    //     referralValid.value = false;
    //     refErrorMsg.value = 'REFERRAL_CODE_IS_NOT_VALID'.tr;
    //   }
    // } else {
    //   resetFocus();
    //   referralValid.value = true;
    //   await Future.delayed(const Duration(milliseconds: 500));
    //   DialogUtil.showErrorMessage('QR_INVALID'.tr);
    // }
  }

  bool isValid() {
    return emailValid.value &&
        emailController.text.isNotEmpty &&
        passValid.value &&
        passwordController.text.isNotEmpty &&
        userValid.value &&
        userNameController.text.isNotEmpty &&
        surNameValid.value &&
        surNameController.text.isNotEmpty &&
        nameValid.value &&
        nameController.text.isNotEmpty &&
        phoneValid.value &&
        phoneController.text.isNotEmpty &&
        rePassValid.value &&
        rePasswordController.text.isNotEmpty;
  }

  bool isValidatePass() {
    return passValid.value && passwordController.text.isNotEmpty;
  }

  toggleShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  toggleShowRePassword() {
    isShowRePassword.value = !isShowRePassword.value;
  }

// bool isValid() {
//   return emailValid.value &&
//       passwordValid.value &&
//       emailController.text.isNotEmpty &&
//       passwordController.text.isNotEmpty;
// }

}
