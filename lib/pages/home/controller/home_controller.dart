import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/pages/acount/acount_dashboard/view/acount_page.dart';
import 'package:tinbanxe/pages/blog/blog_dashboard/view/blog.dart';
import 'package:tinbanxe/pages/dashboard/view/dashboard_page.dart';
import 'package:tinbanxe/pages/notification/notification_dashboard/view/notification_view.dart';
import 'package:tinbanxe/pages/product/product_dashboard/view/product_view.dart';
import 'package:tinbanxe/routes/app_pages.dart';

class HomeController extends GetxController {
  final keyword = ''.obs;
  final pair = <String, dynamic>{}.obs;
  final currentIndex = 0.obs;
  List<Widget> children = [];

  @override
  void onInit() {

    children = [
      DashBoardPage(),
      ProductPage(),
      NotificationPage(),
      AccountPage(),
    ];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Widget get currentPage => children[currentIndex.value];

  onSelectedItem(int index) async {
    currentIndex.value = index;
  }

  onGotoCreatePost() {
    Get.toNamed(Routes.POST_CREATE);
  }
}
