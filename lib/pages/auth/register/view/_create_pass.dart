// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';
// import 'package:tinbanxe/pages/auth/register/controller/register_controller.dart';
// import 'package:tinbanxe/values/setting.dart';
// import 'package:tinbanxe/values/style.dart';
// import 'package:tinbanxe/helpers/extension/responsive.dart';
// import 'package:tinbanxe/widgets/_default_header.dart';
// import 'package:tinbanxe/widgets/_radius_button.dart';
// import 'package:tinbanxe/widgets/_title_default_text_field.dart';
// import 'package:tinbanxe/widgets/custom/customAppBar/custom_app_bar.dart';
//
// class CreatePass extends GetView<RegisterController> {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: context.theme.backgroundColor,
//       child: SafeArea(
//         bottom: false,
//         child: Scaffold(
//           appBar: CustomAppBar(),
//           backgroundColor: context.theme.backgroundColor,
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: GestureDetector(
//                 behavior: HitTestBehavior.translucent,
//                 child: Container(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 16.w),
//                         child: Column(
//                           children: [
//                             DefaultHeader(
//                               padding: EdgeInsets.only(top: 50.w, bottom: 32.w),
//                               title: 'create_pass_title'.tr,
//                               description: 'create_pass_content'.tr,
//                             ),
//                             Obx(() => TittleDefaultTextField(
//                                   width: double.infinity,
//                                   radius: 10,
//                                   controller: controller.passwordController,
//                                   focusNode: controller.passFocus,
//                                   title: 'password'.tr,
//                                   hintText: 'password_placeholder'.tr,
//                                   obscureText: !controller.isShowPassword.value,
//                                   autoFillHints: [AutofillHints.password],
//                                   errorMsg: controller.passValid.value
//                                       ? null
//                                       : controller.passErrorMsg.value,
//                                   innerPadding: EdgeInsets.only(
//                                       top: 16.w,
//                                       bottom: 16.w,
//                                       left: 20.w,
//                                       right: 20.w),
//                                   outsidePadding: EdgeInsets.only(bottom: 16.w),
//                                   suffix: Icon(
//                                     controller.isShowPassword.value
//                                         ? Icons.remove_red_eye
//                                         : Icons.remove_red_eye_outlined,
//                                     color: context.theme.iconTheme.color!
//                                         .withOpacity(0.5),
//                                   ),
//                                   onTabSuffix: controller.toggleShowPassword,
//                                   onChanged: (text) {
//                                     controller.onChangePass(text);
//                                   },
//                                 )),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: Obx(
//                                     () => AnimatedOpacity(
//                                       opacity: controller.hasUppercase.value
//                                           ? 1.0
//                                           : 0.4,
//                                       duration: Duration(milliseconds: 200),
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.check_box_outlined,
//                                             color: controller.hasUppercase.value
//                                                 ? context.theme.primaryColorLight
//                                                 : context.theme.hintColor,
//                                           ),
//                                           SizedBox(width: 5.w),
//                                           Text(
//                                             'pass_valid_upper_case'.tr,
//                                             style: Style().bodyStyle1,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Obx(
//                                     () => AnimatedOpacity(
//                                       opacity:
//                                           controller.hasDigit.value ? 1.0 : 0.4,
//                                       duration: Duration(milliseconds: 200),
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                            Icons.check_box_outlined,
//                                             color: controller.hasDigit.value
//                                                 ? context.theme.primaryColorLight
//                                                 : context.theme.hintColor,
//                                           ),
//                                           SizedBox(width: 5.w),
//                                           Text(
//                                             'pass_valid_number'.tr,
//                                             style: Style().bodyStyle1,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10.w),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: Obx(
//                                     () => AnimatedOpacity(
//                                       opacity: controller.hasLowercase.value
//                                           ? 1.0
//                                           : 0.4,
//                                       duration: Duration(milliseconds: 200),
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.check_box_outlined,
//                                             color: controller.hasLowercase.value
//                                                 ? context.theme.primaryColorLight
//                                                 : context.theme.hintColor,
//                                           ),
//                                           SizedBox(width: 5.w),
//                                           Text(
//                                             'pass_valid_lower_case'.tr,
//                                             style: Style().bodyStyle1,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Obx(
//                                     () => AnimatedOpacity(
//                                       opacity: controller.hasMinLength.value
//                                           ? 1.0
//                                           : 0.4,
//                                       duration: Duration(milliseconds: 200),
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.check_box_outlined,
//                                             color: controller.hasMinLength.value
//                                                 ? context.theme.primaryColorLight
//                                                 : context.theme.hintColor,
//                                           ),
//                                           SizedBox(width: 5.w),
//                                           Text(
//                                             'pass_valid_length'.tr,
//                                             style: Style().bodyStyle1,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 53.w,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Obx(
//                                   () => Center(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5.w)),
//                                       // child:  Image.asset(AppSetting.icSelected, width: 20.w,)
//                                       child: Checkbox(
//                                         materialTapTargetSize:
//                                             MaterialTapTargetSize.padded,
//                                         value: controller.isChecked.value,
//                                         activeColor: context.theme.colorScheme.secondary,
//                                         checkColor: Style.textPrimaryColor,
//                                         onChanged: (value) {
//                                           controller.onChecked(value!);
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     child: RichText(
//                                       textAlign: TextAlign.left,
//                                       text: TextSpan(
//                                         children: [
//                                           TextSpan(
//                                             text: 'create_pass_note_1'.tr + ' ',
//                                             style: Style().textStyle(
//                                               color: context.theme.hintColor,
//                                               fontSize: 13.sp,
//                                               fontFamily: Style.fontBold,
//                                             ),
//                                           ),
//                                           TextSpan(
//                                             text: 'policy'.tr,
//                                             style: Style().textStyle(
//                                               color: context.theme.colorScheme.secondary,
//                                               fontSize: 13.sp,
//                                               fontFamily: Style.fontBold,
//                                             ),
//                                             recognizer:
//                                                 controller.privacyRecognizer,
//                                           ),
//                                           TextSpan(
//                                             text: ' ${'create_pass_note_2'.tr} ',
//                                             style: Style().textStyle(
//                                               color: context.theme.hintColor,
//                                               fontSize: 13.sp,
//                                               fontFamily: Style.fontBold,
//                                             ),
//                                           ),
//                                           TextSpan(
//                                             text: 'terms'.tr,
//                                             style: Style().textStyle(
//                                               color: context.theme.colorScheme.secondary,
//                                               fontSize: 13.sp,
//                                               fontFamily: Style.fontBold,
//                                             ),
//                                             recognizer:
//                                                 controller.termsRecognizer,
//                                           ),
//                                           TextSpan(
//                                             text: ' ${'with_hitrade'.tr}',
//                                             style: Style().textStyle(
//                                               color: context.theme.hintColor,
//                                               fontSize: 13.sp,
//                                               fontFamily: Style.fontBold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Obx(() => RadiusButton(
//                                   isFullWidth: true,
//                                   maxWidth: double.infinity,
//                                   isDisable: !controller.passValid.value ||
//                                       controller
//                                           .passwordController.text.isEmpty ||
//                                       !controller.hasUppercase.value ||
//                                       !controller.hasLowercase.value ||
//                                       !controller.hasDigit.value ||
//                                       !controller.hasMinLength.value,
//                                   radius: 10,
//                                   outsidePadding: EdgeInsets.only(
//                                     top: 23.w,
//                                     bottom: 20.w,
//                                   ),
//                                   innerPadding: controller.loading.value
//                                       ? EdgeInsets.only(
//                                           top: 14.w,
//                                           bottom: 14.w,
//                                           left: 20.w,
//                                           right: 20.w)
//                                       : EdgeInsets.only(
//                                           top: 16.w,
//                                           bottom: 16.w,
//                                           left: 5.w,
//                                           right: 5.w,
//                                         ),
//                                   isLoading: controller.loading.value,
//                                   indicatorSize: 24.w,
//                                   text: 'btn_complete'.tr,
//                                   fontFamily: Style.fontBold,
//                                   fontSize: 16.sp,
//                                   backgroundColor: context.theme.primaryColor,
//                                   textColor: context.textTheme.button!.color,
//                                   onTap: controller.onSubmitRegister,
//                                 )),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 onTap: controller.resetFocus,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
