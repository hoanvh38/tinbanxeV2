import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tinbanxe/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tinbanxe/pages/dashboard/model/car_company_model.dart';
import 'package:tinbanxe/pages/dashboard/widget/blog_widget.dart';
import 'package:tinbanxe/pages/dashboard/widget/full_car_widget.dart';
import 'package:tinbanxe/pages/dashboard/widget/latest_widget.dart';
import 'package:tinbanxe/pages/dashboard/widget/show_room_widget.dart';
import 'package:tinbanxe/pages/dashboard/widget/title_widget.dart';
import 'package:tinbanxe/pages/dashboard/widget/vip_car_widget.dart';
import 'package:tinbanxe/routes/app_pages.dart';
import 'package:tinbanxe/utils/app_util.dart';
import 'package:tinbanxe/utils/date_util.dart';
import 'package:tinbanxe/utils/dialog_util.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_cachedImage.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';

class DashBoardPage extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          resizeToAvoidBottomInset: false,
          body: Obx(
            () {
              return EasyRefresh.custom(
                enableControlFinishRefresh: false,
                controller: controller.ctrRefresh,
                onRefresh: controller.onRefresh,
                header: BezierHourGlassHeader(
                    color: context.theme.primaryColorDark,
                    backgroundColor: context.theme.backgroundColor),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.red,
                    pinned: true,
                    expandedHeight: 75.0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 8.w,
                              ),
                              CircleAvatar(
                                radius: 16.w,
                                backgroundColor: Colors.grey,
                                child: ClipOval(
                                    child: CachedImage(
                                  "https://tinbanxe.vn/" +
                                      controller.user.value.image,
                                  defaultUrl: AppSetting.imgProfile,
                                  width: context.width,
                                  fit: BoxFit.cover,
                                )),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                  controller.user.value.f_name +
                                      ' ' +
                                      controller.user.value.l_name,
                                  style: Style().bodyStyle2.copyWith(
                                      color: context.theme.backgroundColor)),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 8.w),
                            child: Icon(
                              Iconsax.notification,
                              size: 18.w,
                              color: context.theme.backgroundColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    height: 70.w,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(24.w),
                            bottomLeft: Radius.circular(24.w))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tài khoản tinbanxe.vn',
                          style: Style()
                              .bodyStyle1
                              .copyWith(color: context.theme.backgroundColor),
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                controller.isShowAction == false
                                    ? Text(
                                        'Xem số dư',
                                        style: Style().titleStyle1.copyWith(
                                            color:
                                                context.theme.backgroundColor),
                                      )
                                    : Text(
                                        AppUtil.formatMoney(0),
                                        style: Style().titleStyle1.copyWith(
                                            color:
                                                context.theme.backgroundColor),
                                      ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                GestureDetector(
                                  onTap: controller.showAction,
                                  child: Icon(
                                      controller.isShowAction == false
                                          ? Iconsax.eye
                                          : Icons.remove_red_eye_outlined,
                                      color: context.theme.backgroundColor),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                DialogUtil.showToastMessage(
                                    'Chức năng đang được triển khai. Vui lòng quay lại sau');
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.w),
                                decoration: BoxDecoration(
                                    color: context.theme.backgroundColor,
                                    borderRadius: BorderRadius.circular(8.w)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_circle_outlined,
                                      color: context.theme.primaryColorDark,
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      'Nạp tiền',
                                      style: Style().bodyStyle2,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                    height: 10.w,
                  )),
                  SliverToBoxAdapter(
                      child: TitleWidget(
                    onTap: controller.goViewAll,
                    title: 'latest_post'.tr,
                    image: Image.asset(
                      AppSetting.icGiftNew,
                      width: 36.w,
                    ),
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.w),
                          color: context.theme.backgroundColor,
                          child: LatestWidget())),
                  SliverToBoxAdapter(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.w),
                    color: context.theme.cardColor,
                    height: 10.w,
                  )),
                  SliverToBoxAdapter(
                      child: TitleWidget(
                    title: 'Nổi bật'.tr,
                    onTap: controller.goViewAll,
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                          color: context.theme.backgroundColor,
                          child: VipCarWidget())),
                  SliverToBoxAdapter(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.w),
                    color: context.theme.cardColor,
                    height: 10.w,
                  )),
                  SliverToBoxAdapter(
                      child: TitleWidget(
                    title: 'host_showroom'.tr,
                    // sub: 'view_all'.trArgs([
                    //   controller.totalPost.toString()
                    // ]),
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.w),
                          color: context.theme.backgroundColor,
                          child: ShowRoomWidget())),
                  SliverToBoxAdapter(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.w),
                    color: context.theme.cardColor,
                    height: 10.w,
                  )),
                  SliverToBoxAdapter(
                      child: TitleWidget(
                    title: 'car_price'.trArgs([
                      DateUtil.formatDate(DateTime.now(),
                          format: DataFormats.MMMMyyyy)
                    ]),
                  )),
                  SliverToBoxAdapter(
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.w),
                          color: context.theme.backgroundColor,
                          child: buildList(context))),
                  SliverToBoxAdapter(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.w),
                    color: context.theme.cardColor,
                    height: 10.w,
                  )),
                  SliverToBoxAdapter(
                      child: TitleWidget(
                    title: 'Tin tức'.tr,
                    sub: 'view_all'.tr,
                    onTap: () {
                      Get.toNamed(Routes.ALL_BLOG);
                    },
                  )),
                  SliverToBoxAdapter(child: BlogWidget()),
                ],
              );
            },
          )),
    );
  }

  Widget buildList(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          color: context.theme.backgroundColor,
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            crossAxisCount: 3,
            itemCount: controller.listCarModel.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildCatelogy(context, controller.listCarModel[index]),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(1, index.isEven ? 0.8 : 0.8),
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 8.w,
            addAutomaticKeepAlives: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.w),
          child: GestureDetector(
            onTap: () {
              Get.to(() => FullCarWidget());
            },
            child: Text(
              'more'.tr,
              style: Style().primaryStyle.copyWith(
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCatelogy(BuildContext context, CarCompanyModel carCompanyModel) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        controller.openPriceWeb(carCompanyModel.slug);
      },
      child: Container(
        decoration: BoxDecoration(
            color: context.theme.backgroundColor,
            borderRadius: BorderRadius.circular(8.w),
            border: Border.all(width: 0.5.w, color: context.theme.hintColor)),
        padding: EdgeInsets.symmetric(horizontal: 3.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                constraints: BoxConstraints(
                  maxHeight: 36.w,
                  maxWidth: 36.w,
                  minHeight: 36.w,
                  minWidth: 36.w,
                ),
                alignment: Alignment.center,
                child: CachedImage(
                  AppUtil().getImageUrl(key: carCompanyModel.icon),
                  defaultUrl: AppSetting.imgLogo,
                )),
            SizedBox(height: 12.0.w),
            Text(
              carCompanyModel.name,
              textAlign: TextAlign.center,
              style: Style()
                  .bodyStyle1
                  .copyWith(fontSize: 11.sp, letterSpacing: 0.07.sp),
            )
          ],
        ),
      ),
    );
  }
}
