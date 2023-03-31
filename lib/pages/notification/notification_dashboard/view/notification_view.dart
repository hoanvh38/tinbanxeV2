import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tinbanxe/models/notification_model.dart';
import 'package:tinbanxe/pages/notification/notification_dashboard/controller/notification_controller.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_cachedImage.dart';
import 'package:tinbanxe/widgets/custom/customAppBar/custom_app_bar.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/widgets/custom/custom_easy_refresh.dart';

class NotificationPage extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () {
            return CustomEasyRefresh(
              controller: controller.ctlRefresh,
              onRefresh: controller.onRefresh,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildListNotification(
                      context, controller.listNotification[index], index);
                },
                childCount: controller.listNotification.length,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListNotification(
      BuildContext context, NotificationModel notification, index) {
    return InkWell(
      onTap: () => {
        controller.onDetailNotification(notification.title, notification.image,
            notification.description, notification.created_at)
      },
      child: Container(
        margin: EdgeInsets.only(top: index == 0 ? 10.w : 0, left: 16.w, right: 16.w),
        padding: EdgeInsets.symmetric(vertical: 10.0.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5.w,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.notifications_active,
                  color: context.theme.primaryColor,
                  size: 20.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: Style().subtitleStyle1,
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      Text(
                        notification.description,
                        style: Style().subtitleStyle2,
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Text(
                        notification.created_at,
                        style: Style().cardStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
