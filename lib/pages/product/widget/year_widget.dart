import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:tinbanxe/constants/app_constant.dart';
import 'package:tinbanxe/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_custom_header.dart';
import 'package:tinbanxe/widgets/_radius_text_field.dart';
import 'package:tinbanxe/widgets/custom/customAppBar/custom_app_bar.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';

class ListYear extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(height: 8.0.w),
          _buildHeader(context),
          // SizedBox(height: 16.0.w),
          Divider(),
          SizedBox(height: 16.0.w),
          Obx(() {
            final keyword = controller.keyword.value;
            var citis = LIST_YEAR;

            if (keyword.isNotEmpty || keyword != '') {
              citis = LIST_YEAR
                  .where((element) =>
                      TiengViet.parse(element)
                          .toUpperCase()
                          .indexOf(TiengViet.parse(keyword).toUpperCase()) >
                      -1)
                  .toList();
            }

            return SingleChildScrollView(
              child: Container(
                color: context.theme.backgroundColor,
                child: StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  itemCount: citis.length,
                  itemBuilder: (BuildContext context, int index) => items(
                    citis[index],
                    context: context,
                    onTap: () {
                      controller.setYear(citis[index]);
                      // controller.filterByCity(city);
                      Navigator.of(context).pop();
                    },
                    isSelected: citis[index] == controller.year.value,
                  ),
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(1, index.isEven ? 0.5 : 0.5),
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  addAutomaticKeepAlives: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Get.back()),
        Expanded(
          child: Text('year_sx'.tr,
              textAlign: TextAlign.center, style: Style().subtitleStyle1),
        ),
        SizedBox(width: 10.0.w),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.year.value = '';
            Navigator.of(context).pop();
          },
          child: Text(
            'all'.tr,
            style: Style()
                .normalStyle1
                .copyWith(color: context.theme.highlightColor),
          ),
        )
      ],
    );
  }

  Widget items(String city,
      {required BuildContext context,
      GestureTapCallback? onTap,
      bool? isSelected}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 16.w, bottom: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8),
        decoration: BoxDecoration(
            color: isSelected != false
                ? context.theme.colorScheme.secondary
                : context.theme.cardColor,
            borderRadius: BorderRadius.circular(16.w)),
        child: Text(
          city,
          style: TextStyle(
              color: context.textTheme.headline1!.color,
              fontSize: 17.sp,
              fontFamily: Style.fontDemiBold),
        ),
      ),
    );
  }
}
