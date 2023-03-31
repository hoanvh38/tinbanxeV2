import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/pages/acount/accountDetail/controller/account_detail_controller.dart';
import 'package:tinbanxe/pages/acount/accountDetail/widget/content_item.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_cachedImage.dart';
import 'package:tinbanxe/widgets/custom_app_bar.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart'
    '';

class AccountDetailPage extends GetView<AccountDetailController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: CustomAppBar(
          titleColor: context.theme.backgroundColor,
          bgColor: Style.toastErrorBgColor,
          title: 'detail'.tr,
          centerTitle: false,
        ),
        body: SizedBox(
          width: double.infinity,
          // margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildHeader(context),
                buildContent(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    final userModel = controller.user.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 30.w),
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(radius: 75.w,
              backgroundColor: Colors.grey,
              child: ClipOval(
                  child: CachedImage(
                    "https://tinbanxe.vn/" + userModel.image,
                    defaultUrl: AppSetting.imgProfile,
                    width: context.width,
                    fit: BoxFit.cover,
                  )
              ),
            ),
            Positioned(
                right: -7.0.w,
                bottom: 2.0.w,
                child: CircleAvatar(
                    radius: 20.w,
                    backgroundColor: context.theme.cardColor,
                    child: IconButton(
                      icon: Image.asset(
                        AppSetting.ic_camera_icon,
                        color: context.theme.primaryColorDark,
                        // color: Col,
                      ),
                      onPressed: () {},
                    )))
          ],
        ),
      ],
    );
  }

  Widget buildContent(BuildContext context) {
    final userModel = controller.user.value;

    return Column(
      children: [
        SizedBox(height: 30.w),
        ContentItem(
          title: 'email',
          subtitle: userModel.email,
        ),
        ContentItem(
          title: 'Họ tên ',
          subtitle: userModel.f_name +   ' ' +userModel.l_name,
        ),
        ContentItem(
          title: 'Số điện thoại',
          subtitle: userModel.phone,
        ),
        ContentItem(
          title: 'Địa chỉ',
          subtitle: userModel.address,
          imageIcon: AppSetting.icHomeOutlined,
        ),
        // ContentItem(
        //   title: 'address',
        //   subtitle: '${userModel.address?.address}, ${userModel.address?.city}',
        // ),
        SizedBox(height: 20.w),
        // buildLogout(),
      ],
    );
  }
}
