import 'dart:convert';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/pages/myNews/model/my_post_model.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/utils/dialog_util.dart';
import 'package:tinbanxe/utils/error_util.dart';
import 'package:tinbanxe/utils/object_util.dart';

class MyPostController extends GetxController {
  final AuthenticateClient client;

  MyPostController({required this.client});

  final ctlRefresh = EasyRefreshController();
  var loading = false.obs;
  final listPost = <MyPostModel>[].obs;

  @override
  void onInit() {
    fetMyPost();
    super.onInit();
  }

  fetMyPost() async {
    loading.value = true;
    await client.getMyPost().then((response) async {
      print(response);
      if (response.data != null) {
        var ddd = jsonDecode(response.data);
        listPost.assignAll((ddd['rows'] as List)
            .map((e) => MyPostModel.fromJson(e as Map<String, dynamic>))
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

  Future<void> onRefresh() async {
    await fetMyPost();
    ctlRefresh.resetLoadState();
    ctlRefresh.finishRefresh();
  }
}
