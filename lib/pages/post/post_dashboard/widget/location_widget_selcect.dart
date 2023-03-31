import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:tinbanxe/constants/app_constant.dart';
import 'package:tinbanxe/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:tinbanxe/pages/post/post_dashboard/widget/custom_hearder_filter.dart';
import 'package:tinbanxe/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_custom_header.dart';
import 'package:tinbanxe/widgets/_radius_text_field.dart';
import 'package:tinbanxe/widgets/custom/customAppBar/custom_app_bar.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';

class SearchCityPage extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.w),
        topRight: Radius.circular(32.w),
      )),
      child: Column(
        children: [
          CustomHeaderFilter(
            title: 'Khu vực',
          ),
          SizedBox(
            height: 16.w,
          ),
          RadiusTextField(
            width: double.infinity,
            radius: 10,
            isAutoFocus: false,
            controller: controller.citySearchController,
            focusNode: controller.searchFocus,
            bgColor: context.theme.cardColor,
            hintText: 'search_location'.tr,
            hintColor: context.textTheme.bodyText2!.color,
            textColor: context.textTheme.bodyText2!.color,
            fontSize: 14.sp,
            shadowColor: Style.transparent,
            preIcon: Container(
              margin: EdgeInsets.only(left: 20.w),
              child: Image.asset(
                AppSetting.icSearch,
                width: 16.w,
                height: 16.w,
                color: context.textTheme.bodyText2!.color,
                fit: BoxFit.scaleDown,
              ),
            ),
            innerPadding:
                EdgeInsets.only(top: 7.w, bottom: 7.w, left: 20.w, right: 20.w),
            onChanged: (value) {
              // controller.handleSearchCity(value);
            },
          ),
          SizedBox(height: 16.0.w),
          Obx(() {
            final keyword = controller.locationKeyword.value;
            var citis = LIST_CITY;

            if (keyword.isNotEmpty || keyword != '') {
              citis = LIST_CITY
                  .where((element) =>
                      TiengViet.parse(element)
                          .toUpperCase()
                          .indexOf(TiengViet.parse(keyword).toUpperCase()) >
                      -1)
                  .toList();
            }

            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: citis
                      .map<Widget>((city) => cityItem(
                            city,
                            context: context,
                            onTap: () {
                              controller.location.value = city;
                              Navigator.of(context).pop();
                              FocusScope.of(Get.context!)
                                  .requestFocus(new FocusNode());
                            },
                            isSelected: city == controller.location.value,
                          ))
                      .toList(),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget cityItem(String city,
      {required BuildContext context,
      GestureTapCallback? onTap,
      bool? isSelected}) {
    return Container(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: isSelected!
                        ? context.theme.highlightColor
                        : context.theme.hintColor,
                    size: 22.w,
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: Text(
                      city,
                      style: Style().noteStyleRegular,
                    ),
                  ),
                  isSelected
                      ? Icon(
                          Icons.check_sharp,
                          color: context.theme.primaryColorLight,
                          size: 22.w,
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Container(
                height: 0.5.w,
                color: context.textTheme.caption!.color,
                margin: EdgeInsets.only(top: 16.w, bottom: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
