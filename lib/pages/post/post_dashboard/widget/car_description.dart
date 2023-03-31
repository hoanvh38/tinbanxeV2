import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/helpers/formatter/numericFormatter.dart';
import 'package:tinbanxe/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:tinbanxe/pages/post/post_dashboard/widget/car_category_value.dart';
import 'package:tinbanxe/pages/post/post_dashboard/widget/car_company_widget.dart';
import 'package:tinbanxe/pages/post/post_dashboard/widget/car_line_widget.dart';
import 'package:tinbanxe/pages/post/post_dashboard/widget/info_car_widget.dart';
import 'package:tinbanxe/pages/post/post_dashboard/widget/select_year.dart';
import 'package:tinbanxe/utils/app_util.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_default_text_field.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';

class CarDescription extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // buildCarCategory(context),
            // buildCarCompany(context),
            buildContent(context, title: 'Loại xe', onTap: () {
              Get.bottomSheet(
                  CarCategoryValue(
                    value: controller.carCategoryDefault.value,
                    onTap: (value) {
                      controller.setCarCategory(value);
                    },
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.w),
                        topRight: Radius.circular(16.w)),
                  ),
                  backgroundColor: context.theme.backgroundColor,
                  isScrollControlled: false);
            },
                value:
                    AppUtil().carCategory(controller.carCategoryDefault.value)),
            Obx(
              () => buildContent(
                context,
                title: 'Hãng xe',
                value: controller.carCompanyValue.value.title,
                onTap: () {
                  Get.bottomSheet(CarCompanyWidget(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Dòng xe',
                value: controller.carLine.value.title,
                onTap: () {
                  Get.bottomSheet(CarLineWidget(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Năm sản xuất',
                value: controller.year.value.toString(),
                onTap: () {
                  Get.bottomSheet(SelectYearWidget(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            SizedBox(
              height: 16.w,
            ),
            Text(
              'Phiên bản',
              style: Style().bodyStyle2,
            ),
            SizedBox(
              height: 16.w,
            ),
            DefaultTextField(
              width: double.infinity,
              radius: 10,
              controller: controller.versionCarController,
              focusNode: controller.versionFocus,
              textInputType: TextInputType.text,
              autoFillHints: [AutofillHints.email],
              hintText: 'Ví dụ G,E,LX...',
              isAutoFocus: false,
              onChanged: (text) {
                // controller.onChangeUserName(text);
                // controller.onChangeReferral(text);
              },
            ),
            SizedBox(
              height: 16.w,
            ),
            Text(
              'Giá bán',
              style: Style().bodyStyle2,
            ),
            SizedBox(
              height: 16.w,
            ),
            DefaultTextField(
              width: double.infinity,
              radius: 10,
              controller: controller.priceController,
              focusNode: controller.priceFocus,
              textInputType: TextInputType.number,
              isAutoFocus: false,
              autoFillHints: [AutofillHints.email],
              inputFormatter: [DecimalFormatter(decimalDigits: 0)],
              onChanged: (text) {
                // controller.onChangeUserName(text);
                // controller.onChangeReferral(text);
              },
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Xuất xứ',
                value: controller.originValue.value.title,
                onTap: () {
                  Get.bottomSheet(
                      CartInfoWidget(
                        listInfo: controller.origin.value.listvalue,
                        headerTitle: 'Xuất xứ',
                        infoSeted: controller.originValue.value,
                        onTap: (value) {
                          controller.setOrigin(value);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Kiểu dáng',
                value: controller.carStylingValue.value.title,
                onTap: () {
                  Get.bottomSheet(
                      CartInfoWidget(
                        listInfo: controller.carStyling.value.listvalue,
                        headerTitle: 'Kiểu dáng',
                        infoSeted: controller.carStylingValue.value,
                        height: context.height * 0.45,
                        onTap: (value) {
                          controller.setCarStyle(value);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Nhiên liệu',
                value: controller.fuelValue.value.title,
                onTap: () {
                  Get.bottomSheet(
                      CartInfoWidget(
                        listInfo: controller.fuel.value.listvalue,
                        headerTitle: 'Nhiên liệu',
                        infoSeted: controller.fuelValue.value,
                        height: context.height * 0.3,
                        onTap: (value) {
                          controller.setFuleCar(value);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            Obx(
              () => buildContent(
                context,
                title: 'Tình trạng',
                value: controller.carStatusValue.value.title,
                onTap: () {
                  Get.bottomSheet(
                      CartInfoWidget(
                        listInfo: controller.carStatus.value.listvalue,
                        headerTitle: 'Tình trạng',
                        infoSeted: controller.carStatusValue.value,
                        onTap: (value) {
                          controller.setCarStatus(value);
                        },
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.w),
                            topRight: Radius.circular(16.w)),
                      ),
                      backgroundColor: context.theme.backgroundColor,
                      isScrollControlled: false);
                },
              ),
            ),
            Obx(
              () => controller.carCategoryDefault.value == 0
                  ? buildContent(
                      context,
                      title: 'Màu xe',
                      value: controller.carColorValue.value.title,
                      onTap: () {
                        Get.bottomSheet(
                            CartInfoWidget(
                              listInfo: controller.carColor.value.listvalue,
                              headerTitle: 'Màu xe',
                              infoSeted: controller.carColorValue.value,
                              height: context.height * 0.5,
                              onTap: (value) {
                                controller.setCarColor(value);
                              },
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.w),
                                  topRight: Radius.circular(16.w)),
                            ),
                            backgroundColor: context.theme.backgroundColor,
                            isScrollControlled: false);
                      },
                    )
                  : buildContent(
                      context,
                      title: 'Tải trọng',
                      value: controller.weightValue.value.title,
                      onTap: () {
                        Get.bottomSheet(
                            CartInfoWidget(
                              listInfo: controller.weight.value.listvalue,
                              headerTitle: 'Tải trọng',
                              infoSeted: controller.weightValue.value,
                              height: context.height * 0.4,
                              onTap: (value) {
                                controller.setWeightCar(value);
                              },
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.w),
                                  topRight: Radius.circular(16.w)),
                            ),
                            backgroundColor: context.theme.backgroundColor,
                            isScrollControlled: false);
                      },
                    ),
            ),
            Obx(
              () => controller.carCategoryDefault.value == 0
                  ? buildContent(
                      context,
                      title: 'Hộp số',
                      value: controller.gearValue.value.title,
                      onTap: () {
                        Get.bottomSheet(
                            CartInfoWidget(
                              listInfo: controller.gear.value.listvalue,
                              headerTitle: 'Hộp số',
                              infoSeted: controller.gearValue.value,
                              height: 200.w,
                              onTap: (value) {
                                controller.setGerCar(value);
                              },
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.w),
                                  topRight: Radius.circular(16.w)),
                            ),
                            backgroundColor: context.theme.backgroundColor,
                            isScrollControlled: false);
                      },
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context,
      {String? title, String? value, GestureTapCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(context, title: title),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.0.w, horizontal: 16.0.w),
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  value ?? '',
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
      ],
    );
  }

  Widget buildTitle(BuildContext context, {String? title}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.w, top: 16.w),
      child: Row(
        children: [
          Text(
            title ?? '',
            style: Style().bodyStyle2,
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(
            '*',
            style:
                Style().bodyStyle2.copyWith(color: context.theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
