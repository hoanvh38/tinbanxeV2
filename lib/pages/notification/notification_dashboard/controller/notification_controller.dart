import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/models/notification_model.dart';
import 'package:tinbanxe/pages/notification/notification_dashboard/view/notification_detail.dart';
import 'package:tinbanxe/pages/splash/model/meta_pagination_model.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/utils/dialog_util.dart';

class NotificationController extends GetxController {
  final AuthenticateClient client;
  var listNotification = <NotificationModel>[].obs;
  var imageDetail = '';
  var titleDetail = '';
  var descDetail = '';
  var createdDetail = '';

  NotificationController({required this.client});
  var meta = MetaPaginationModel().obs;
  final ctlRefresh = EasyRefreshController();
  final isLoading = false.obs;
  @override
  void onInit() {
    isLoading.value = true;
    getAllNotification();
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAllNotification() async {
    try {
      var response = await client.getListNotification();
      if (response.statusCode == 200) {
        listNotification.assignAll((response.data as List)
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList());
      } else {
        DialogUtil.showErrorMessage('not_data'.tr);
      }
    } catch (error) {
      print(error);
      DialogUtil.showErrorMessage('system_error'.tr);
    }
  }

  onDetailNotification(
      String title, String image, String desc, String created) {
    titleDetail = title;
    imageDetail = image;
    descDetail = desc;
    createdDetail = created;
    Get.to(() => NotificationDetailPage());
  }


  Future<void> onRefresh() async {
    await getAllNotification();
    ctlRefresh.resetLoadState();
    ctlRefresh.finishRefresh();
  }

  Future<void> onLoading() async {
    meta.value.offset++;
    try {
      var response = await client.getListNotification(offset: listNotification.length);
      if (response.data != null) {
        listNotification.addAll((response.data as List)
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
    } catch (error) {
      print(error);
    }
  }
}
