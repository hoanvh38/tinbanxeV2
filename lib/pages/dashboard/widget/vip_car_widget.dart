import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/constants/app_constant.dart';
import 'package:tinbanxe/models/base_model.dart';
import 'package:tinbanxe/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tinbanxe/pages/dashboard/model/car_model.dart';
import 'package:tinbanxe/routes/app_pages.dart';
import 'package:tinbanxe/utils/app_util.dart';
import 'package:tinbanxe/utils/date_util.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_cachedImage.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/flutter_slimmer.dart';

class VipCarWidget extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Obx(
      () {
        final list = controller.listVipPost;
        if (controller.loadingListVip.value && list.isEmpty) {
          return Column(
              children: listSimple.map((e) => VipCarSlimmer()).toList());
        }
        return Column(
            children: list.map((e) => buildModel(context, e)).toList());
      },
    ));
  }

  Widget buildModel(BuildContext context, CarModel model) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_CAR, arguments: {
          'carId' : model.id.toString(),
          'address': model.infocar.first.location
        });
      },
      child: Container(
        height: 140.w,
        padding: EdgeInsets.symmetric(vertical: 16.0.w, horizontal: 16.w),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 1.0.w,
            color: Color.fromRGBO(157, 163, 172, 0.36),
          ),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  border:
                      Border.all(width: 2.w, color: context.theme.cardColor)),
              height: 120.w,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w),
                  child: CachedImage(
                    AppUtil().getImageUrl(key: model.thumbnail),
                    defaultUrl: AppSetting.imgNoCar,
                    height: context.width,
                    width: context.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: Style().subtitleStyle2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Text(
                    model.infocar.first.namsx.toString() +
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
            )
          ],
        ),
      ),
    );
  }
}
