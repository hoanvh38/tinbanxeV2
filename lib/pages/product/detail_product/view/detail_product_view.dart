import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/pages/dashboard/model/car_model.dart';
import 'package:tinbanxe/pages/product/detail_product/controller/detail_controller.dart';
import 'package:tinbanxe/pages/product/detail_product/view/review_screen.dart';
import 'package:tinbanxe/pages/product/widget/read_more.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/routes/app_pages.dart';
import 'package:tinbanxe/utils/app_util.dart';
import 'package:tinbanxe/utils/date_util.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_cachedImage.dart';
import 'package:tinbanxe/widgets/_rating_widget.dart';
import 'package:tinbanxe/widgets/custom_app_bar.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    @override
    final controller = Get.put(
      DetailCarController(
        client: AuthenticateClient(),
      ),
      tag: Get.arguments['carId'] as String,
    );
    return Material(
      child: Scaffold(
          backgroundColor: context.theme.cardColor,
          appBar: CustomAppBar(
            titleColor: context.theme.backgroundColor,
            bgColor: Style.toastErrorBgColor,
            title: 'detail'.tr,
            centerTitle: false,
            actionButton: GestureDetector(
              onTap: () {
                controller.sharePost(controller.carModel.value.slug);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Icon(
                  Icons.share,
                  color: context.theme.backgroundColor,
                ),
              ),
            ),
          ),
          body: Obx(
            () => controller.loading.value
                ? Center(
                    child: SpinKitThreeBounce(
                      color: context.theme.primaryColor,
                      size: 24,
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.w),
                                  color: context.theme.cardColor,
                                  child: buildImage(context, controller)),
                              SizedBox(height: 8.w),
                              buildInfoCar(context, controller),
                              buildListMoreCar(context, controller)
                            ],
                          ),
                        ),
                      ),
                      buildFooter(context, controller)
                    ],
                  ),
          )),
    );
  }

  Widget buildImage(BuildContext context, DetailCarController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          buildBigImage(context, controller),
          SizedBox(
            height: 8.w,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...List.generate(
                    controller.carModel.value.images.length,
                    (index) =>
                        buildSmallProductPreview(context, index, controller)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBigImage(BuildContext context, DetailCarController controller) {
    return Padding(
      padding: EdgeInsets.only(top: 10.w),
      child: Obx(() => Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  viewportFraction: 1.0,
                  aspectRatio: context.isTablet
                      ? context.width / 320.w
                      : context.width / 160.w,
                  enlargeCenterPage: true,
                  height: context.isTablet ? 320.w : 220.w,
                  onPageChanged: (index, reason) {
                    controller.indexImage.value = index;
                  },
                ),
                items: controller.carModel.value.images
                    .map(
                      (banner) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.w),
                          child: CachedImage(
                            AppUtil().getImageUrl(
                                key: controller.carModel.value
                                    .images[controller.indexImage.value]),
                            defaultUrl: AppSetting.imgLogo,
                            fit: BoxFit.cover,
                            height: 220.w,
                            width: context.width,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Positioned(
                left: 0,
                bottom: 18.w,
                right: 0,
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.carModel.value.images
                          .asMap()
                          .entries
                          .map((entry) {
                        return Container(
                          width: 8.w,
                          height: 8.w,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.w, horizontal: 4.w),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber.withOpacity(
                                  controller.indexImage.value == entry.key
                                      ? 0.9
                                      : 0.1)),
                        );
                      }).toList(),
                    )),
              ),
            ],
          )),
    );
  }

  Widget buildSmallProductPreview(
      BuildContext context, int index, DetailCarController controller) {
    return GestureDetector(
      onTap: () {
        controller.setDefaultImage(index);
      },
      child: Opacity(
        opacity: controller.indexImage.value == index ? 1 : 0.5,
        child: Container(
          // duration: Duration(seconds: 4),
          margin: EdgeInsets.only(right: 8.w),
          height: 120.w,
          width: 180.w,
          decoration: BoxDecoration(
            color: Colors.white
                .withOpacity(controller.indexImage.value == index ? 1 : 0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.w),
            child: CachedImage(
              AppUtil()
                  .getImageUrl(key: controller.carModel.value.images[index]),
              defaultUrl: AppSetting.imgLogo,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoCar(BuildContext context, DetailCarController controller) {
    final carModel = controller.carModel.value;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      width: context.width,
      decoration: BoxDecoration(
          color: context.theme.backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.w), topRight: Radius.circular(24.w))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            carModel.name,
            style: Style().subtitleStyle1,
          ),
          SizedBox(
            height: 8.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppUtil.formatMoney(carModel.price) +
                    ' - ( ${carModel.price_text} )',
                style: Style()
                    .primaryStyle
                    .copyWith(color: context.theme.primaryColor),
              ),
              Image.asset(
                AppSetting.icHeartOutline,
                color: context.theme.hintColor,
              )
            ],
          ),
          SizedBox(
            height: 8.w,
          ),
          Row(
            children: [
              Text(DateUtil.timeAgoSinceDate(carModel.created_at!),
                  style: Style().hintStyle.copyWith(fontSize: 15.sp)),
              SizedBox(
                width: 16.w,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16.w,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    carModel.infocar.first.location,
                    style: Style().highlightStyle,
                  )
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.to(ReviewProductScreen());
            },
            child: OpenFlutterProductRating(
              rating: 3,
              ratingCount: 5,
              alignment: MainAxisAlignment.start,
            ),
          ),
          Divider(
            color: context.theme.hintColor,
          ),
          Text(
            'contact_info'.tr,
            style: Style().primaryStyle,
          ),
          SizedBox(
            height: 8.w,
          ),
          buildContact(context, controller),
          Divider(
            color: context.theme.hintColor,
          ),
          Text(
            'info'.tr,
            style: Style().primaryStyle,
          ),
          SizedBox(
            height: 4.w,
          ),
          _buildInfo(context,
              widget: Image.asset(
                AppSetting.icLich,
                height: 24.w,
              ),
              title: 'year_info',
              sub: carModel.infocar.first.namsx.toString()),
          _buildInfo(context,
              widget: Image.asset(
                AppSetting.icTinhTrang,
                height: 24.w,
              ),
              title: 'tinhtrang',
              sub: carModel.infocar.first.tinhtrang),
          _buildInfo(context,
              widget: Icon(Icons.location_on_outlined),
              title: 'location',
              sub: controller.address.value),
          _buildInfo(context,
              widget: Image.asset(
                AppSetting.icHaveVideo,
                height: 24.w,
              ),
              title: 'have_video',
              sub: carModel.video_url != ''
                  ? carModel.video_url
                  : 'no_have_video'.tr),
          Divider(
            color: context.theme.hintColor,
          ),
          Text(
            'mota'.tr,
            style: Style().primaryStyle,
          ),
          ReadMoreText(
            controller.carDetail.value.replaceAll('<br />', ''),
            trimMode: TrimMode.Line,
            trimLines: 3,
            trimExpandedText: 'load_less'.tr,
            trimCollapsedText: 'show_less'.tr,
            style: Style().bodyStyle1,
            moreStyle: Style().primaryStyle.copyWith(
                  color: context.theme.highlightColor,
                  fontFamily: Style.fontRegular,
                  decoration: TextDecoration.underline,
                ),
            lessStyle: Style().primaryStyle.copyWith(
                  color: context.theme.highlightColor,
                  fontFamily: Style.fontRegular,
                  decoration: TextDecoration.underline,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context,
      {Widget? widget, String? title, String? sub}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                widget!,
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  title!.tr,
                  style: Style()
                      .normalStyle4
                      .copyWith(fontFamily: Style.fontRegular),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              sub!,
              style: Style().normalStyle4,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContact(BuildContext context, DetailCarController controller) {
    return Row(
      children: [
        Image.asset(AppSetting.icAccountFilled),
        SizedBox(
          width: 16.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.carModel.value.added_by,
              style: Style().subtitleStyle2,
            ),
            GestureDetector(
              onTap: () {
                launch("tel:${controller.carModel.value.phone}");
              },
              child: Text('contact_now'.tr + controller.carModel.value.phone,
                  style: Style().bodyStyle1.copyWith(
                      color: context.theme.highlightColor,
                      decoration: TextDecoration.underline)),
            ),
          ],
        )
      ],
    );
  }

  Widget buildFooter(BuildContext context, DetailCarController controller) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: buildButton(context, isHide: false, onTap: () {
                launch("tel:${controller.carModel.value.phone}");
              }, icons: Icons.add_ic_call_outlined, text: 'call_now')),
          Expanded(
              flex: 3,
              child: buildButton(context, onTap: () async {
                if (Platform.isAndroid) {
                  String uri = 'sms:${controller.carModel.value.phone}';
                  if (await canLaunch(uri)) {
                    await launch(uri);
                  } else {
                    throw 'Could not launch $uri';
                  }
                }
                // Android
                else {
                  String uri = 'sms:${controller.carModel.value.phone}';
                  if (await canLaunch(uri)) {
                    await launch(uri);
                  } else {
                    throw 'Could not launch $uri';
                  }
                }

                // iOS
              }, icons: Icons.message_sharp, text: 'message_now')),
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context,
      {bool isHide = true,
      String? text,
      IconData? icons,
      GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        color: isHide != false
            ? context.theme.colorScheme.secondary
            : context.theme.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icons,
              color: isHide != true
                  ? context.theme.backgroundColor
                  : context.textTheme.headline1!.color,
              size: 24,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              text!.tr,
              style: Style().bodyStyle1.copyWith(
                    color: isHide != true
                        ? context.theme.backgroundColor
                        : context.theme.textTheme.headline1!.color,
                  ),
            )
          ],
        ),
      ),
    );
  }

  buildListMoreCar(BuildContext context, DetailCarController controller) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.w,
            ),
            Text(
              'Tin liên quan',
              style: Style().subtitleStyle1,
            ),
            Column(
              children: controller.listAllProduct
                  .map<Widget>(
                    (carModel) => itemCar(context, carModel),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCar(BuildContext context, CarModel model) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_CAR,
            arguments: {
              'carId': model.id.toString(),
              'address': model.infocar.first.location
            },
            preventDuplicates: false);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0.w),
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
                    defaultUrl: AppSetting.imgLogo,
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
