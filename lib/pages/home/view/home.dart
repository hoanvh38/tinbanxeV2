import 'package:animations/animations.dart';
import 'package:tinbanxe/pages/home/controller/home_controller.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/custom/animatedBottomNavigationBar/animated_bottom_navigation_bar.dart';
import 'package:tinbanxe/widgets/indexed_transition_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Material(
        color: context.theme.backgroundColor,
        child: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            backgroundColor: context.theme.backgroundColor,
            body: Obx(() {
              return IndexedTransitionSwitcher(
                transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    ) {
                  return FadeThroughTransition(
                    fillColor: Colors.transparent,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
                index: controller.currentIndex.value,
                children: controller.children,
              );
            }),
            floatingActionButton: FloatingActionButton(
              elevation: 8,
              backgroundColor: context.theme.primaryColor,
              child: Icon(
                Icons.add,
                color: Style.textWhiteColor,
              ),
              onPressed: () {
                controller.onGotoCreatePost();
              },
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              itemCount: controller.children.length,
              tabBuilder: (int index, bool isActive) {
                return _buildBottomNavBar(context, isActive)[index];
              },
              backgroundColor: context.theme.backgroundColor,
              activeIndex: controller.currentIndex.value,
              splashColor: context.theme.primaryColor,
              splashSpeedInMilliseconds: 300,
              notchSmoothness: NotchSmoothness.defaultEdge,
              gapLocation: GapLocation.center,
              leftCornerRadius: 32.w,
              rightCornerRadius: 32.w,
              onTap: controller.onSelectedItem,
            ),
          ),
        ),
      );
    });
  }

  List<Widget> _buildBottomNavBar(BuildContext context, bool isActive) {
    return [
      _buildBottomNavigationBarItem(
        context,
        'tab_home'.tr,
        AppSetting.icHomeOutlined,
        AppSetting.icHomeFilled,
        0,
        isActive,
      ),
      _buildBottomNavigationBarItem(
        context,
        'Tìm kiếm'.tr,
        AppSetting.icSearch,
        AppSetting.icSearch,
        1,
        isActive,
      ),
      _buildBottomNavigationBarItem(
        context,
        'Thông báo'.tr,
        AppSetting.ic_bell,
        AppSetting.ic_bell,
        2,
        isActive,
      ),
      _buildBottomNavigationBarItem(
        context,
        'tab_account'.tr,
        AppSetting.icAccountOutlined,
        AppSetting.icAccountOutlined,
        3,
        isActive,
      ),
    ];
  }

  Widget _buildBottomNavigationBarItem(BuildContext context, String title,
      String iconUri, String activeIconUri, int idx, bool active) {
    return Padding(
      padding: EdgeInsets.only(top: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedCrossFade(
            crossFadeState:
            active ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 250),
            firstChild: Image.asset(
              activeIconUri,
              color: context.theme.primaryColor
            ),
            secondChild: Image.asset(
              iconUri,
              color: context.theme.unselectedWidgetColor,
            ),
          ),
          SizedBox(height: 4.w),
          Text(
            title,
            style: TextStyle(
              fontFamily: Style.fontMedium,
              fontSize: 12.sp,
              color: active
                  ? context.theme.primaryColor
                  : context.theme.unselectedWidgetColor,
              letterSpacing: -0.24,
            ),
          )
        ],
      ),
    );
  }
}
