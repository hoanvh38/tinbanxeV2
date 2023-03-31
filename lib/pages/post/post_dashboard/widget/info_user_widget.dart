import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:tinbanxe/pages/post/post_dashboard/widget/location_widget_selcect.dart';
import 'package:tinbanxe/pages/post/post_dashboard/widget/text_warning.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_default_text_field.dart';

class InfoUserWidget extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWarning(
            title: 'Họ tên người bán',
          ),
          DefaultTextField(
            width: double.infinity,
            radius: 10,
            maxLines: null,
            controller: controller.nameController,
            focusNode: controller.nameFocus,
            textInputType: TextInputType.text,
            autoFillHints: [AutofillHints.email],
            hintText: 'vd : Nguyễn Văn A',
            isAutoFocus: false,
            onChanged: (text) {},
          ),
          TextWarning(
            title: 'Điện thoại',
          ),
          DefaultTextField(
            width: double.infinity,
            radius: 10,
            maxLines: null,
            controller: controller.phoneController,
            focusNode: controller.phoneFocus,
            textInputType: TextInputType.phone,
            autoFillHints: [AutofillHints.email],
            hintText: 'vd : 098888xxxx',
            isAutoFocus: false,
            onChanged: (text) {
              controller.onDesChange(text);
              // controller.onChangeReferral(text);
            },
          ),
          TextWarning(
            title: 'Địa chỉ',
          ),
          DefaultTextField(
            width: double.infinity,
            radius: 10,
            maxLines: null,
            controller: controller.addressController,
            focusNode: controller.addressFocus,
            textInputType: TextInputType.streetAddress,
            autoFillHints: [AutofillHints.addressCity],
            hintText: 'Nhập địa chỉ',
            isAutoFocus: false,
            onChanged: (text) {
              controller.onDesChange(text);
              // controller.onChangeReferral(text);
            },
          ),
          TextWarning(
            title: 'Khu vực',
          ),
          Obx(
            () => GestureDetector(
              onTap: () {
                FocusScope.of(Get.context!).requestFocus(new FocusNode());
                Get.bottomSheet(SearchCityPage(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.w),
                          topRight: Radius.circular(16.w)),
                    ),
                    backgroundColor: context.theme.backgroundColor,
                    isScrollControlled: false);
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: 16.0.w, horizontal: 16.0.w),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      controller.location.value,
                      style: TextStyle(
                          fontFamily: Style.fontRegular,
                          fontSize: 15.sp,
                          color: context.textTheme.headline1!.color),
                    ),
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
