import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/pages/notification/notification_dashboard/controller/notification_controller.dart';
import 'package:tinbanxe/values/setting.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_cachedImage.dart';
import 'package:tinbanxe/widgets/_custom_header.dart';
import 'package:tinbanxe/widgets/custom/customAppBar/custom_app_bar.dart';

class NotificationDetailPage extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: CustomHeaderWidget(
            title: 'Chi tiết thông báo',
          ),
          body: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.5.w, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.mark_email_unread,
                        color: context.theme.highlightColor,
                        size: 20.w,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.titleDetail,
                              style: Style().subtitleStyle1,
                            ),
                            SizedBox(
                              height: 5.w,
                            ),
                            Text(
                              controller.createdDetail,
                              style: Style().cardStyle,
                            ),
                            SizedBox(
                              height: 15.w,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.w,
                ),
                Container(
                  child: Text(
                    controller.descDetail,
                    style: Style().subtitleStyle2,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
