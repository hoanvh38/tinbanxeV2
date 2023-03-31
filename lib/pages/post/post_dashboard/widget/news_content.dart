import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:tinbanxe/pages/post/post_dashboard/widget/text_warning.dart';
import 'package:tinbanxe/helpers/extension/responsive.dart';
import 'package:tinbanxe/values/style.dart';
import 'package:tinbanxe/widgets/_default_text_field.dart';

class NewContent extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => TextWarning(
                title: 'Tiêu đề',
                subTile: '${controller.titleLength.value}/100',
              ),
            ),
            DefaultTextField(
              width: double.infinity,
              radius: 10,
              maxLines: null,
              maxLength: 100,
              controller: controller.titleCarController,
              focusNode: controller.titleCarFocus,
              textInputType: TextInputType.text,
              autoFillHints: [AutofillHints.email],
              hintText: 'Tối thiểu 50 kí tự',
              isAutoFocus: false,
              onChanged: (text) {
                controller.onChangeTitle(text);
                // controller.onChangeReferral(text);
              },
            ),
            buildSugget(context),
            Obx(
              () => TextWarning(
                title: 'Mô tả',
                subTile: '${controller.desLength.value}/255',
              ),
            ),
            DefaultTextField(
              width: double.infinity,
              radius: 10,
              maxLines: 10,
              maxLength: 255,
              controller: controller.describeCarController,
              focusNode: controller.describeCarFocus,
              textInputType: TextInputType.text,
              autoFillHints: [AutofillHints.email],
              hintText: 'Tối thiểu 50 kí tự',
              isAutoFocus: false,
              onChanged: (text) {
                controller.onDesChange(text);
                // controller.onChangeReferral(text);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSugget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16.w,
        ),
        Text(
          'Gợi ý:',
          style: Style().highlightStyle,
        ),
        SizedBox(
          height: 4.w,
        ),
        buildSuccgetText(
            context,
            'Cần bán xe ' +
                controller.carCompanyValue.value.title +
                ' phiên bản ' +
                controller.carLine.value.title +
                ' đời ${controller.year.value}'),
        SizedBox(
          height: 4.w,
        ),
        buildSuccgetText(
            context,
            'Cần bán xe ' +
                controller.carCompanyValue.value.title +
                ' phiên bản ' +
                controller.carLine.value.title +
                ' đời ${controller.year.value} ${controller.originValue.value.title.toLowerCase()} tình trạng ${controller.carStatusValue.value.title.toLowerCase()}'),
      ],
    );
  }

  Widget buildSuccgetText(
    BuildContext context,
    String text,
  ) {
    return GestureDetector(
        onTap: () {
          controller.titleCarController.text = text;
          controller.onChangeTitle(text);
        },
        child: Text(
          '- ' + text,
          style: Style()
              .subtitleStyle1
              .copyWith(color: context.theme.primaryColorDark),
        ));
  }
}
