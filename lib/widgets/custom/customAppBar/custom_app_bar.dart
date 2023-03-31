import 'package:flutter/material.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Widget? actionButton;
  final Color? titleColor;
  final VoidCallback? onTitleClick;
  final VoidCallback? onBackPress;
  final Widget? titleWidget;
  final bool? enableBack;
  final bool? centerTitle;
  final double height;

  CustomAppBar({
    Key? key,
    this.title,
    this.actionButton,
    this.titleColor,
    this.onTitleClick,
    this.onBackPress,
    this.titleWidget,
    this.enableBack = true,
    this.centerTitle = false,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: centerTitle!,
      leading: enableBack!
          ? IconButton(
              icon:Icon(
                Icons.arrow_back_ios,

              ),
              onPressed: () {
                if (onBackPress == null) {
                  Get.back();
                } else {
                  onBackPress!();
                }
              })
          : null,
      title: GestureDetector(
        onTap: onTitleClick ?? () {},
        child: Row(
          children: [
            Expanded(
                child: Text(
              title ?? '',
              textAlign: centerTitle! ? TextAlign.center : TextAlign.left,
              style: Style().subtitleStyle1,
              maxLines: 2,
            )),
            SizedBox(width: 10.w),
            titleWidget != null ? titleWidget! : SizedBox(),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 0.w),
          child: actionButton ?? SizedBox(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
