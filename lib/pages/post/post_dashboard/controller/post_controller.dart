import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tinbanxe/models/vehicle_model.dart';
import 'package:tinbanxe/pages/dashboard/model/car_company_model.dart';
import 'package:tinbanxe/pages/post/post_dashboard/model/image_upload.dart';
import 'package:tinbanxe/pages/post/post_dashboard/model/info_post_model.dart';
import 'package:tinbanxe/pages/post/post_dashboard/model/info_value.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/utils/dialog_util.dart';
import 'package:tinbanxe/utils/error_util.dart';
import 'package:tinbanxe/utils/object_util.dart';
import 'package:tinbanxe/widgets/camera_vietnamese_text_delegate.dart';
import 'package:tinbanxe/widgets/vietnamese_text_delegate.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:tinbanxe/helpers/extension/validator.dart';

class PostController extends GetxController {
  final AuthenticateClient client;

  //images

  dynamic pickImageError;

  final pageController = PageController();
  var activeStep = 0.obs;

  PostController({required this.client});

  final TextEditingController carCompanySearch = TextEditingController();
  final FocusNode carCompanyFocus = FocusNode();
  final TextEditingController carLineController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController youtubeController = TextEditingController();
  final TextEditingController versionCarController = TextEditingController();
  final TextEditingController titleCarController = TextEditingController();
  final TextEditingController describeCarController = TextEditingController();
  final TextEditingController citySearchController = TextEditingController();
  final FocusNode carLineFocus = FocusNode();
  final FocusNode searchFocus = FocusNode();
  final FocusNode titleCarFocus = FocusNode();
  final FocusNode describeCarFocus = FocusNode();
  final FocusNode versionFocus = FocusNode();
  final FocusNode youtubFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  var carCompanySearchValue = ''.obs;
  var carLineSearchValue = ''.obs;
  var carCompanyValue = CarCompanyModel().obs;
  var carLine = VehicleModel().obs;
  final imageCar = ImageUploadModel().obs;
  var carCategoryDefault = 0.obs;
  final listFullCar = <CarCompanyModel>[].obs;
  final listCarLine = <VehicleModel>[].obs;
  final year = '2022'.obs;
  final location = ''.obs;
  final locationKeyword = ''.obs;
  final listCarInfo = <InfoPostModel>[].obs;

  final origin = InfoPostModel().obs;
  final carStyling = InfoPostModel().obs;
  final fuel = InfoPostModel().obs;
  final carStatus = InfoPostModel().obs;
  final carColor = InfoPostModel().obs;
  final gear = InfoPostModel().obs;
  final weight = InfoPostModel().obs;

  final originValue = InfoValueModel().obs;
  final carStylingValue = InfoValueModel().obs;
  final fuelValue = InfoValueModel().obs;
  final carStatusValue = InfoValueModel().obs;
  final carColorValue = InfoValueModel().obs;
  final gearValue = InfoValueModel().obs;
  final weightValue = InfoValueModel().obs;
  var titleLength = 0.obs;
  var desLength = 0.obs;
  var titleValue = true.obs;
  var desValue = true.obs;
  var listCar = <ImageUploadModel>[].obs;

  var loading = false.obs;

  // final List<String> suggetTittle = [
  //   'Cần bán xe ${carCompanyValue.value.title}'
  // ]

  @override
  void onInit() {
    super.onInit();
    fetchFullCarModel();
    fetchInfoPost();
  }

  @override
  void onClose() {
    super.onClose();
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }

  uploadMedia() async {
    try {
      final List<AssetEntity>? assets = await AssetPicker.pickAssets(
        Get.context!,
        pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
          textDelegate: VietnameseTextDelegate(),
          specialItemPosition: SpecialItemPosition.prepend,
          specialItemBuilder:
              (BuildContext context, AssetPathEntity? path, int length) {
            if (path?.isAll != true) {
              return null;
            }

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                final AssetEntity? result = await CameraPicker.pickFromCamera(
                  Get.context!,
                  pickerConfig: CameraPickerConfig(
                    enableRecording: false,
                    textDelegate: CameraVietnamTextDelegate(),
                  ),
                );
                if (result != null) {
                  final File? image = await result.file;
                  if (image != null) {
                    final Directory appDirectory =
                        await getApplicationDocumentsDirectory();
                    final String path = appDirectory.path;
                    File? compressedImage =
                        await FlutterImageCompress.compressAndGetFile(
                      image.path,
                      '$path/${image.path.split('/').last}',
                      quality: 50,
                    );
                    DialogUtil.showProgressDialog(Get.context!);
                    await client
                        .uploadImage(compressedImage!)
                        .then((response) async {
                      var ddd = jsonDecode(response.data);
                      print(ddd);

                      if (ddd != null) {
                        imageCar.value = ImageUploadModel.fromJson(ddd['0']);
                        listCar.insert(0, imageCar.value);
                        print(imageCar);
                      }
                    }).catchError((error, trace) async {
                      ErrorUtil.catchError(error, trace);
                    });
                  }
                  Get.back();
                  Get.back();
                  if (Get.isDialogOpen ?? false) {
                    Get.back();
                  }
                  // handleResult(context, result);
                }
              },
              child: const Center(
                child: Icon(Icons.camera_enhance, size: 42.0),
              ),
            );
          },
        ),
      );

      if (assets != null && assets.isNotEmpty) {
        final File? image = await assets.first.file;
        if (image != null) {
          final Directory appDirectory =
              await getApplicationDocumentsDirectory();
          final String path = appDirectory.path;
          File? compressedImage = await FlutterImageCompress.compressAndGetFile(
            image.path,
            '$path/${image.path.split('/').last}',
            quality: 50,
          );
          DialogUtil.showProgressDialog(Get.context!);
          await client.uploadImage(compressedImage!).then((response) async {
            var ddd = jsonDecode(response.data);
            print(ddd);

            if (ddd != null) {
              imageCar.value = ImageUploadModel.fromJson(ddd['0']);
              listCar.insert(0, imageCar.value);
              print(imageCar);
            }
          }).catchError((error, trace) async {
            ErrorUtil.catchError(error, trace);
          });
        }

        Get.back();
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      }
    } catch (e) {
      pickImageError = e;
    }
  }

  nextScreen() {
    if (activeStep < 2) {
      activeStep.value++;
    }
  }

  setCarCategory(int index) {
    if (index != carCategoryDefault.value) {
      resetInfo();
    }
    carCategoryDefault.value = index;
    fetchFullCarModel();
    fetchInfoPost();
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
    Get.back();
  }

  fetchFullCarModel() async {
    await client
        .getCarCompanyByType(carCategoryDefault.value)
        .then((response) async {
      print(response);
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

  fetchCarLine() async {
    await client
        .getListVehicleByCarId(brandId: carCompanyValue.value.id)
        .then((response) async {
      print(response);
      if (response.data != null) {
        var ddd = jsonDecode(response.data);
        listCarLine.assignAll((ddd as List)
            .map((e) => VehicleModel.fromJson(e as Map<String, dynamic>))
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

  fetchInfoPost() async {
    await client
        .getInfoPost(loaixe: carCategoryDefault.value)
        .then((response) async {
      print(response);
      if (response.data['chung'] != null) {
        listCarInfo.assignAll((response.data['chung'] as List)
            .map((e) => InfoPostModel.fromJson(e as Map<String, dynamic>))
            .toList());
        if (listCarInfo.isNotEmpty) {
          origin.value =
              listCarInfo.singleWhere((element) => element.column == 'xuatxu');
          carStyling.value = listCarInfo
              .singleWhere((element) => element.column == 'kieudang');
          fuel.value = listCarInfo
              .singleWhere((element) => element.column == 'nhienlieu');
          carStatus.value = listCarInfo
              .singleWhere((element) => element.column == 'tinhtrang');
          carColor.value =
              listCarInfo.singleWhere((element) => element.column == 'mauxe');
          gear.value =
              listCarInfo.singleWhere((element) => element.column == 'hopso');
          weight.value = listCarInfo
              .singleWhere((element) => element.column == 'taitrong');
        }
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

  handleSearchBranch(String value) {
    carCompanySearchValue.value = value;
  }

  handleCarLine(String value) {
    carLineSearchValue.value = value;
  }

  setYear(String value) {
    year.value = value;
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
    Get.back();
  }

  setCarCompany(CarCompanyModel model) {
    if (model != carCompanyValue.value) {
      carLine.value = VehicleModel();
    }
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
    carCompanyValue.value = model;
    fetchCarLine();
    Get.back();
  }

  setCarline(VehicleModel model) {
    carLine.value = model;
    fetchCarLine();
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
    Get.back();
  }

  setOrigin(InfoValueModel valueModel) {
    originValue.value = valueModel;
    Get.back();
  }

  setCarStyle(InfoValueModel valueModel) {
    carStylingValue.value = valueModel;
    Get.back();
  }

  setFuleCar(InfoValueModel valueModel) {
    fuelValue.value = valueModel;
    Get.back();
  }

  setCarStatus(InfoValueModel valueModel) {
    carStatusValue.value = valueModel;
    Get.back();
  }

  setCarColor(InfoValueModel valueModel) {
    carColorValue.value = valueModel;
    Get.back();
  }

  setWeightCar(InfoValueModel valueModel) {
    weightValue.value = valueModel;
    Get.back();
  }

  setGerCar(InfoValueModel valueModel) {
    gearValue.value = valueModel;
    Get.back();
  }

  resetInfo() {
    carCompanyValue.value = CarCompanyModel();
    carLine.value = VehicleModel();
    originValue.value = InfoValueModel();
    carStylingValue.value = InfoValueModel();
    fuelValue.value = InfoValueModel();
    carStatusValue.value = InfoValueModel();
    carColorValue.value = InfoValueModel();
    weightValue.value = InfoValueModel();
    gearValue.value = InfoValueModel();
  }

  bool isValidUpload() {
    return listCar.isNotEmpty;
  }

  bool isValidInfoXeHoi() {
    return carCompanyValue.value.title.isNotEmpty &&
        carLine.value.title.isNotEmpty &&
        originValue.value.title.isNotEmpty &&
        fuelValue.value.title.isNotEmpty &&
        carStylingValue.value.title.isNotEmpty &&
        carColorValue.value.title.isNotEmpty &&
        carStatusValue.value.title.isNotEmpty &&
        gearValue.value.title.isNotEmpty;
  }

  bool isValidInfoXeTai() {
    return carCompanyValue.value.title.isNotEmpty &&
        carLine.value.title.isNotEmpty &&
        originValue.value.title.isNotEmpty &&
        fuelValue.value.title.isNotEmpty &&
        carStylingValue.value.title.isNotEmpty &&
        carStatusValue.value.title.isNotEmpty &&
        weightValue.value.title.isNotEmpty;
  }

  onChangeTitle(String value) {
    titleValue.value = titleCarController.text.isNotEmpty;
    titleLength.value = value.length;
  }

  onDesChange(String value) {
    desValue.value = describeCarController.text.isNotEmpty;
    desLength.value = value.length;
  }

  bool isValid() {
    if (activeStep == 0) {
      return isValidUpload();
    } else if (activeStep == 1 && carCategoryDefault.value == 0) {
      return isValidInfoXeHoi();
    } else if (activeStep == 1 && carCategoryDefault.value == 1) {
      return isValidInfoXeTai();
    } else if (activeStep == 2) {
      return true;
    }
    return true;
  }

  checkValid() {
    if (titleCarController.text.isEmpty) {
      return DialogUtil.showErrorToast('Vui lòng nhập tiêu để');
    }
    if (describeCarController.text.isEmpty) {
      return DialogUtil.showErrorToast('Vui lòng nhập mô tả');
    }
    if (titleLength.value < 50) {
      return DialogUtil.showErrorToast('Tiêu đề phải có từ 50 kí tự trở lên');
    }
    if (desLength.value < 50) {
      return DialogUtil.showErrorToast('Mô tả phải có từ 50 kí tự trở lên');
    }
    return activeStep.value++;
  }

  postNews() async {
    if (nameController.text.isEmpty) {
      return DialogUtil.showErrorToast('Vui lòng nhập họ tên');
    }
    if (phoneController.text.isEmpty) {
      return DialogUtil.showErrorToast('Vui lòng nhập Số điện thoại');
    }

    if (!phoneController.text.isValidPhone()) {
      return DialogUtil.showErrorToast('Số điện thoại chưa đúng định dạng');
    }
    if (addressController.text.isEmpty) {
      return DialogUtil.showErrorToast('Vui lòng nhập địa chỉ');
    }
    if (location.value == '') {
      return DialogUtil.showErrorToast('Vui lòng chọn khu vực');
    }

    var amount =
        priceController.text.isNotEmpty ? priceController.text.trim() : '0';
    double amountDouble = double.parse(amount.replaceAll(RegExp(','), ''));
    final List<String> img = listCar.map((e) => e.name).toList();
    String result = img
        .map((val) => val.trim())
        .join(',');
    print(result);
    final data = {
      'm': 1,
      'hangxeid': carCompanyValue.value.id,
      'dongxeid': carLine.value.id,
      'namsx': year.value,
      'phienban': versionCarController.text,
      'giaban': amountDouble,
      'images': result,
      'title': titleCarController.text,
      'mota': describeCarController.text,
      'video': youtubeController.text,
      'fullname': nameController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'location': location.value,
      'xuatxu': originValue.value.title,
      'kieudang': carStylingValue.value.title,
      'nhienlieu': fuelValue.value.title,
      'tinhtrang': carStatusValue.value.title,
      'mauxe': carColorValue.value.title,
      'hopso': gearValue.value.title,
      'taitrong': weightValue.value.title,
    };
    print(data);
    loading.value = true;
    await client.ceateNews(data).then((response) async {
      var ddd = jsonDecode(response.data);
      print(ddd);

      if (ddd['success'] == 'ok') {
        DialogUtil.showSuccessMessage(
            'Tạo tin thành công, chúng tôi sẽ sớm xét duyệt bài đăng của bạn !');
        Get.back();
      }
      loading.value = false;
    }).catchError((error, trace) async {
      DialogUtil.showSuccessToast(
          'Tạo tin thất bại. Vui lòng kiểm tra lại thông tin');
      loading.value = false;
      ErrorUtil.catchError(error, trace);
    });
  }

  removeImage(ImageUploadModel model) {
    listCar.remove(model);
    listCar.refresh();
  }
}
