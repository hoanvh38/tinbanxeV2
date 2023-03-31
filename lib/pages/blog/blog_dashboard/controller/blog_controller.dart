import 'dart:convert';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/models/blog_model.dart';
import 'package:tinbanxe/pages/blog/blog_dashboard/view/blog_details.dart';
import 'package:tinbanxe/pages/splash/model/meta_pagination_model.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/utils/dialog_util.dart';
import 'package:tinbanxe/utils/error_util.dart';
import 'package:tinbanxe/utils/object_util.dart';

class BlogController extends GetxController {
  var blogs = <BlogModel>[].obs;
  final AuthenticateClient client;
  var detailBlog = '';
  var titleDetail = '';

  BlogController({required this.client});

  final isLoading = false.obs;
  var meta = MetaPaginationModel().obs;
  final ctlRefresh = EasyRefreshController();
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getBlog();
  }

  getBlog() async {
    loading.value = true;
    await client.getAllBlog(limit: 20).then((response) async {
      print(response);
      if (response.data != null) {
        blogs.assignAll((response.data['blogs'] as List)
            .map((e) => BlogModel.fromJson(e as Map<String, dynamic>))
            .toList());

      }
      loading.value = false;
    }).catchError((error, trace) async {
      loading.value = false;

      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  showBlogDetail(String url, String title) async {
    try {
      detailBlog = url;
      titleDetail = title;
      Get.to(() => BlogDetailsPage());
    } catch (error) {
      print(error);
    }
  }

  Future<void> onRefresh() async {
    await getBlog();
    ctlRefresh.resetLoadState();
    ctlRefresh.finishRefresh();
  }

  // Future<void> onLoading() async {
  //   if (meta.value.page + 1 <= metaOrder.value.totalPage) {
  //   await client.getAllBlog(limit: 20, offset:  blogs.length).then((response) async {
  //     print(response);
  //     if (response.data != null) {
  //       blogs.assignAll((response.data['blogs'] as List)
  //           .map((e) => BlogModel.fromJson(e as Map<String, dynamic>))
  //           .toList());
  //
  //       meta.value = MetaPaginationModel.fromJson(response.data['data']);
  //     }
  //     loading.value = false;
  //   }).catchError((error, trace) async {
  //     loading.value = false;
  //
  //     String? msg = ErrorUtil.getError(error, trace);
  //     if (ObjectUtil.isNotEmpty(msg)) {
  //       DialogUtil.showErrorMessage(msg!.tr);
  //     } else {
  //       DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
  //     }
  //   });
  // }}
}
