import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/databases/user_db.dart';
import 'package:tinbanxe/models/banner_model.dart';
import 'package:tinbanxe/models/blog_model.dart';
import 'package:tinbanxe/models/user_model.dart';
import 'package:tinbanxe/pages/dashboard/model/car_company_model.dart';
import 'package:tinbanxe/pages/dashboard/model/car_model.dart';
import 'package:tinbanxe/pages/dashboard/model/showroom_model.dart';
import 'package:tinbanxe/pages/home/controller/home_controller.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/utils/app_util.dart';
import 'package:tinbanxe/utils/dialog_util.dart';
import 'package:tinbanxe/utils/error_util.dart';
import 'package:tinbanxe/utils/object_util.dart';
import 'package:tinbanxe/widgets/custom/custom_web.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardController extends GetxController {
  final AuthenticateClient client;

  DashBoardController({required this.client});

  final user = UserModel().obs;
  final bannerIndex = 0.obs;
  final listBanner = <BannerModel>[].obs;
  final listLatestPost = <CarModel>[].obs;
  final listVipPost = <CarModel>[].obs;
  var totalPost = 0.obs;
  final ctrRefresh = EasyRefreshController();
  final scrollController = ScrollController();
  final listShowroom = <ShowRoomModel>[].obs;
  final listCarModel = <CarCompanyModel>[].obs;
  final listFullCar = <CarCompanyModel>[].obs;
  final loadingListBanner = false.obs;
  final loadingListBlog = false.obs;
  final loadingListLatest = false.obs;
  final loadingListVip = false.obs;
  final  headerOffset = 0.0.obs;
  final List<String> text = [
    "Honda HR-V 2022 ra mắt tại Việt Nam, giá từ 826 triệu đồng",
    "VinFast VF8 đã được cấp giấy chứng nhận chất lượng tại Việt Nam"
  ];
  final isShowAction = false.obs;
  var blogs = <BlogModel>[].obs;

  @override
  void onInit() {
    user.value = UserDB().currentUser() ?? UserModel();
    init();
    super.onInit();
  }

  showAction() {
    isShowAction.value = !isShowAction.value;
  }

  @override
  void onClose() {
    super.onClose();
  }

  init()  {
     getBlog();
     getBanner();
     fetchLatestPost();
     fetchVipCar();
     fetchShowroom();
     fetchCarModel();
     fetchFullCarModel();
  }
 setOFFSET (double value){
    headerOffset.value = value;
 }
  getBanner() async {
    loadingListBanner.value = true;
    await client.getBanner().then((response) async {
      print(response);
      if (response.data != null) {
        listBanner.assignAll((response.data as List)
            .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
      loadingListBanner.value = false;
    }).catchError((error, trace) async {
      loadingListBanner.value = false;
      print(error);
      print(trace);
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  getBlog() async {
    loadingListBlog.value = true;
    await client.getAllBlog().then((response) async {
      print(response);
      if (response.data != null) {
        blogs.assignAll((response.data['blogs'] as List)
            .map((e) => BlogModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
      loadingListBlog.value = false;
    }).catchError((error, trace) async {
      loadingListBlog.value = false;
      print(error);
      print(trace);
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  Future<void> onRefresh() async {
    ctrRefresh.resetLoadState();
    ctrRefresh.finishRefresh();
  }

  fetchLatestPost() async {
    loadingListLatest.value = true;
    await client.fetchLatestCar().then((response) async {
      // totalPost.value = response.data['total_size'];
      // print(response);
      if (response.data['products'] != null) {
        print(response.data['products']);
        listLatestPost.assignAll((response.data['products'] as List)
            .map((e) => CarModel.fromJson(e as Map<String, dynamic>))
            .toList());
        totalPost.value = response.data['total_size'];
        // BannerDB().save(listBanner.value);
      }
      loadingListLatest.value = false;
    }).catchError((error, trace) async {
      print(error);
      print(trace);
      loadingListLatest.value = false;
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  goViewAll() {
    Get.back();
    // home.onSelectedItem(1);
  }

  fetchVipCar() async {
    loadingListVip.value =true;
    await client.fetchVipProduct().then((response) async {
      totalPost.value = response.data['total_size'];
      if (response.data['products'] != null) {
        print(response.data['products']);
        listVipPost.assignAll((response.data['products'] as List)
            .map((e) => CarModel.fromJson(e as Map<String, dynamic>))
            .toList());
        // BannerDB().save(listBanner.value);
      }
      loadingListVip.value =false;
    }).catchError((error, trace) async {
      loadingListVip.value =false;
      print(error);
      print(trace);
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  fetchShowroom() async {
    await client.fetchShowroom().then((response) async {
      if (response.data['brands'] != null) {
        print(response.data['brands']);
        listShowroom.assignAll((response.data['brands'] as List)
            .map((e) => ShowRoomModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
    }).catchError((error, trace) async {
      print(error);
      print(trace);
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  fetchCarModel() async {
    await client.fetchCarModel().then((response) async {
      if (response.data != null) {
        listCarModel.assignAll((response.data as List)
            .map((e) => CarCompanyModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
    }).catchError((error, trace) async {
      print(error);
      print(trace);
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  fetchFullCarModel() async {
    await client.fetchCarModel(limit: 100).then((response) async {
      // print(response);
      if (response.data != null) {
        listFullCar.assignAll((response.data as List)
            .map((e) => CarCompanyModel.fromJson(e as Map<String, dynamic>))
            .toList());
        // BannerDB().save(listBanner.value);
      }
    }).catchError((error, trace) async {
      print(error);
      print(trace);
      String? msg = ErrorUtil.getError(error, trace);
      if (ObjectUtil.isNotEmpty(msg)) {
        DialogUtil.showErrorMessage(msg!.tr);
      } else {
        DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
      }
    });
  }

  launchNumber(String phoneNumber) async {
    String url = "tel://" + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call';
    }
  }

  openPriceWeb(String url) {
    Get.to(() => CustomWebView(url: AppUtil().hosting(key: url + '?t=mobile')));
  }
}
