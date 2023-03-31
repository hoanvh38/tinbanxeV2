import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tinbanxe/pages/dashboard/model/car_model.dart';
import 'package:tinbanxe/pages/product/detail_product/model/car_detail_model.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/utils/app_util.dart';
import 'package:tinbanxe/utils/dialog_util.dart';
import 'package:tinbanxe/utils/error_util.dart';
import 'package:tinbanxe/utils/object_util.dart';

class DetailCarController extends GetxController {
  final AuthenticateClient client;

  DetailCarController({required this.client});

  final carModel = DetailCarModel().obs;
  final indexImage = 0.obs;
  final carDetail = ''.obs;
  final listAllProduct = <CarModel>[].obs;
  final loading = false.obs;
  final carId = ''.obs;
  final address = ''.obs;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is Map) {
      carId.value = Get.arguments['carId'] as String;
    }
    if (Get.arguments != null && Get.arguments is Map) {
      address.value = Get.arguments['address'] as String;
    }

    super.onInit();
    init();
  }

  setDefaultImage(int index) {
    indexImage.value = index;
  }

  init() async {
    await getDetailCar();
    fetchAllList();
  }

  getDetailCar() async {
    loading.value = true;
    await client.detailCar(carId.value).then((response) async {
      print(response);
      if (response.data != null) {
        carDetail.value = response.data['details'];
        carModel.value = DetailCarModel.fromJson(response.data);
      }
      loading.value = false;
    }).catchError((error, trace) async {
      loading.value = false;
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

  fetchAllList() async {
    await client.relatedProduct(carModel.value.brand_id).then((response) async {
      // print(response);
      if (response.data['products'] != null) {
        print(response.data['products']);
        listAllProduct.assignAll((response.data['products'] as List)
            .map((e) => CarModel.fromJson(e as Map<String, dynamic>))
            .toList());
      }
    }).catchError((error, trace) async {
      ErrorUtil.catchError(error, trace);
    });
  }

  sharePost(String slug) async {
    await Share.share(AppUtil().hosting(key: slug));
  }
}
