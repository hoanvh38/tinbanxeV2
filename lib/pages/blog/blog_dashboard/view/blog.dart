import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/models/blog_model.dart';
import 'package:tinbanxe/pages/blog/blog_dashboard/controller/blog_controller.dart';
import 'package:tinbanxe/utils/app_util.dart';
import 'package:tinbanxe/utils/date_util.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_cachedImage.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/_custom_header.dart';
import 'package:tinbanxe/widgets/custom/custom_easy_refresh.dart';
import 'package:tinbanxe/widgets/custom/custom_indicator.dart';
import 'package:tinbanxe/widgets/custom/custom_web.dart';

class BlogPage extends GetView<BlogController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomHeaderWidget(
            title: 'Tin tức',
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Obx(() {
            final listBlog = controller.blogs;
            final loading = controller.loading.value;
            final metaList = controller.meta.value;
            if (loading && listBlog.isEmpty) {
              return Center(
                child: CustomIndicator(),
              );
            }

            return CustomEasyRefresh(
              controller: controller.ctlRefresh,
              onRefresh: controller.onRefresh,
              infoText:
                  'show'.tr + ': ${listBlog.length}/ ${metaList.total_size}',
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return buildItem(context, listBlog[index], index);
                },
                childCount: listBlog.length,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, BlogModel blog, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(() =>
            CustomWebView(url: AppUtil().url(key: blog.url), title: ''.tr));
      },
      child: Container(
        margin: EdgeInsets.only(top: index == 0 ? 10.w : 0),
        padding: EdgeInsets.symmetric(vertical: 10.0.w, horizontal: 16.w),
        child: SizedBox(
          height: 100.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.theme.cardColor,
                  ),
                  child: CachedImage(
                    AppUtil().getImage(key: blog.urlToImage),
                    defaultUrl: AppSetting.imgLogo,
                    height: 100.w,
                    width: 100.w,
                    fit: BoxFit.cover,
                    radius: 4,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: Style().subtitleStyle1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      blog.description,
                      style: Style().subtitleStyle2.copyWith(fontSize: 13.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateUtil.formatDate(
                          DateUtil.getDateTimeByMs(blog.publishedAt * 1000),
                          format: DataFormats.ddMMyyyyHHmm),
                      style: Style().cardStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
