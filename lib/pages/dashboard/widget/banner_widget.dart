import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/constants/app_constant.dart';
import 'package:tinbanxe/models/user_model.dart';
import 'package:tinbanxe/routes/app_pages.dart';
import 'package:tinbanxe/utils/app_util.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tinbanxe/widgets/_cachedImage.dart';
import 'package:tinbanxe/widgets/custom/custom_web.dart';
import 'package:tinbanxe/widgets/flutter_slimmer.dart';

class HeaderWidget extends GetView<DashBoardController> {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBanner(context),
        ],
      ),
    );
  }

  _buildBanner(BuildContext context) {
    return Obx(() {
      final loading = controller.loadingListBanner.value;
      if (loading && controller.listBanner.isEmpty) {
        return Padding(
            padding: EdgeInsets.only(top: 10.w, left: 16.w, right: 16.w),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 8),
                viewportFraction: 1,
                aspectRatio: 1,
                enlargeCenterPage: false,
                height: context.width * 0.5,
                onPageChanged: (index, reason) {},
              ),
              items: listSimple
                  .map((nft) => const MediumNFTShimmer())
                  .toList(),
            ));
      }
      return Padding(
          padding: EdgeInsets.only(top: 10.w, left: 16.w, right: 16.w),
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 8),
                  viewportFraction: 1,
                  aspectRatio: 1,
                  enlargeCenterPage: false,
                  height: context.width * 0.5,
                  onPageChanged: (index, reason) {},
                ),
                items: controller.listBanner
                    .map(
                      (banner) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.w),
                            border: Border.all(
                                width: 2, color: context.theme.dividerColor)),
                        margin: EdgeInsets.symmetric(horizontal: 0.w),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: CachedImage(
                              'https://tinbanxe.vn/' + banner.photo,
                              defaultUrl: AppSetting.imgLogo,
                              height: context.width * 0.5,
                              width: context.width,
                              fit: BoxFit.cover,
                              radius: 12,
                              boxDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          onTap: () {
                            // AppUtil().goDetailNFT(nft);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ));
    });
  }

  _buildFlashNews(BuildContext context) {
    return Obx(() {
      final loading = controller.loadingListBlog.value;
      if (loading && controller.blogs.isEmpty) {
        return Container(
          padding: EdgeInsets.only(top: 15.w, bottom: 11.w),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          // decoration: BoxDecoration(
          //   color: context.theme.cardColor,
          //   borderRadius: BorderRadius.circular(12),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ListTileShimmer(
                isDisabledAvatar: true,
              ),
              const Icon(Icons.read_more),
            ],
          ),
        );
      }
      return Container(
        padding: EdgeInsets.only(top: 15.w, bottom: 11.w),
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: CarouselSlider(
              options: CarouselOptions(
                  scrollDirection: Axis.vertical,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  height: 30.w),
              items: controller.blogs
                  .map(
                    (blogs) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Text(
                          blogs.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Style().normalStyle1,
                        ),
                        onTap: () {
                          Get.to(() => CustomWebView(
                              url: AppUtil().url(key: blogs.url), title: ''.tr));
                        }),
                  )
                  .toList(),
            )),
            SizedBox(width: 7.w),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.ALL_BLOG);
              },
              behavior: HitTestBehavior.translucent,
              child: const Icon(Icons.read_more),
            ),
          ],
        ),
      );

    });
  }
}
