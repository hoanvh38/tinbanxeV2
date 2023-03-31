import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:tinbanxe/pages/acount/acount_dashboard/controller/acount_controller.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_cachedImage.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';

class ProfilePic extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    String img = controller.user.value.image;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          child: ClipOval(
              child: CachedImage(
            "https://tinbanxe.vn/" + img,
            defaultUrl: AppSetting.imgProfile,
            width: context.width,
            fit: BoxFit.cover,
          )
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Text(
          controller.user.value.email,
          style: Style().subtitleStyle1,
        )
      ],
    );
  }
}
