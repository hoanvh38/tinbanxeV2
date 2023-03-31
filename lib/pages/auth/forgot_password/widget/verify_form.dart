import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tinbanxe/pages/auth/forgot_password/controller/forgot_password_controller.dart';

class VerifyFormWidget extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: PinCodeTextField(
          appContext: context,
          pastedTextStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          obscureText: false,
          obscuringCharacter: '*',
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            inactiveFillColor: context.theme.disabledColor,
            inactiveColor: context.theme.cardColor,
            disabledColor: context.theme.backgroundColor,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor: controller.hasError ? Colors.orange : Colors.white,
          ),
          cursorColor: Colors.black,
          animationDuration: Duration(milliseconds: 300),
          textStyle: TextStyle(fontSize: 20, height: 1.6),
          enableActiveFill: true,
          controller: controller.otpController,
          keyboardType: TextInputType.text,

          onChanged: (value) {
            controller.onChangeOTP(value);
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            return true;
          },
        ),
      ),
    );
  }
}
