import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/constants/app_constant.dart';
import 'package:tinbanxe/pages/post/post_dashboard/model/info_value.dart';
import 'package:tinbanxe/pages/post/post_dashboard/widget/custom_hearder_filter.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';

class CartInfoWidget extends StatelessWidget {
  final List<InfoValueModel> listInfo;
  final String? headerTitle;
  final InfoValueModel? infoSeted;
  final double? height;
  final Function(InfoValueModel model) onTap;

  CartInfoWidget(
      {required this.listInfo,
      this.headerTitle,
      this.height,
      this.infoSeted,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200.w,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          CustomHeaderFilter(
            title: headerTitle,
          ),
          SizedBox(
            height: 16.w,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listInfo
                    .map<Widget>((model) => buildItem(model,
                        context: context, isSelected: model == infoSeted))
                    .toList(),
              ),
            ),
          ),
          // SizedBox(height: 16.0.w),
        ],
      ),
    );
  }

  Widget buildItem(InfoValueModel model,
      {required BuildContext context, bool? isSelected}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap(model);
        FocusScope.of(Get.context!).requestFocus(new FocusNode());
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  model.title,
                  style: isSelected!
                      ? Style().noteStyleRegular
                      : Style()
                          .noteStyleRegular
                          .copyWith(color: context.theme.hintColor),
                ),
              ),
              isSelected
                  ? Icon(
                      Icons.check_circle_outline_sharp,
                      color: context.theme.primaryColorLight,
                    )
                  : const SizedBox(),
            ],
          ),
          SizedBox(
            height: 12.w,
          )
        ],
      ),
    );
  }
}
