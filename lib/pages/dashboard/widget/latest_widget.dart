import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/constants/app_constant.dart';
import 'package:tinbanxe/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tinbanxe/pages/dashboard/model/car_model.dart';
import 'package:tinbanxe/routes/app_pages.dart';
import 'package:tinbanxe/utils/app_util.dart';
import 'package:tinbanxe/utils/date_util.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_cachedImage.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/flutter_slimmer.dart';

class LatestWidget extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() {
        if (controller.loadingListLatest.value &&
            controller.listLatestPost.isEmpty) {
          return Row(
            children: listSimple.map((e) => PlayStoreShimmer()).toList(),
          );
        }
        return Row(
          children: controller.listLatestPost
              .map<Widget>(
                (carModel) => buildItem(context, carModel),
              )
              .toList(),
        );
      }),
    );
  }

  Widget buildItem(BuildContext context, CarModel model) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_CAR, arguments: {
          'carId': model.id.toString(),
          'address': model.infocar.first.location
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.w),
        child: SizedBox(
          width: 140,
          child: GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: model.id.toString(),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.w),
                        child: CachedImage(
                          AppUtil().getImageUrl(key: model.thumbnail),
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                SizedBox(height: 10.w),
                Text(
                  model.name,
                  style: Style().subtitleStyle2,
                  maxLines: 2,
                ),
                SizedBox(height: 5.w),
                Text(
                  model.infocar.first.namsx +
                      ' - ' +
                      model.infocar.first.tinhtrang,
                  style: Style()
                      .bodyStyle1
                      .copyWith(color: context.theme.hintColor),
                  maxLines: 2,
                ),
                SizedBox(height: 5.w),
                Text(
                  model.price > 0
                      ? AppUtil.formatMoney(model.price)
                      : 'contact'.tr,
                  style: Style()
                      .subtitleStyle1
                      .copyWith(color: context.theme.primaryColor),
                  maxLines: 2,
                ),
                SizedBox(height: 5.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateUtil.timeAgoSinceDate(model.created_at!),
                      style: Style().normalStyle3,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Text(
                        model.infocar.first.location,
                        style: Style()
                            .normalStyle3
                            .copyWith(color: context.theme.highlightColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
