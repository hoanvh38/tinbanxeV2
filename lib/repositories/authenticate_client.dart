import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:tinbanxe/repositories/base_client.dart';
import 'package:tinbanxe/utils/app_util.dart';

class AuthenticateClient extends BaseClient {
  final client = BaseClient.instance.dio;

  //Auth
  Future<Response> login(String email, String password) async {
    return BaseClient.instance.dio.post('$authServiceBaseUrl/auth/login',
        data: {'email': email, 'password': password});
  }

  Future<Response> register(Map<String, dynamic> data) async {
    return client.post(
      '$authServiceBaseUrl/auth/register',
      data: data,
    );
  }

  Future<Response> forgotPassword(String email) async {
    return client.post(
      '$authServiceBaseUrl/auth/forgot-password',
      data: {'email': email},
    );
  }

  Future<Response> verifyCode(String otp, String email) async {
    return client.post(
      '$authServiceBaseUrl/auth/forgot-password/active',
      data: {'email': email, 'keyactive': otp},
    );
  }

  Future<Response> changePassword(String email, String password) async {
    return client.post(
      '$authServiceBaseUrl/auth/forgot-password/changepassword',
      data: {'email': email, 'password': password},
    );
  }

  Future<Response> confirmReset(String email, String resetCode) async {
    return client.post('$authServiceBaseUrl/confirm-reset',
        data: {'email': email, 'resetCode': resetCode});
  }

  Future<Response> getAccountInfo() async {
    return client.get('$authServiceBaseUrl/customer/info');
  }

  Future<Response> getBanner() async {
    return client.get('$authServiceBaseUrl/banners?banner_type=main_banner');
  }

//Product

  Future<Response> fetchLatestCar() async {
    return client.get('$authServiceBaseUrl/products?type=latest&limit=10');
  }
  // Future<Response> fetchLatestCar() async {
  //   return client.get('$authServiceBaseUrl/products?type=latest&limit=10');
  // }

  Future<Response> getConfig() async {
    return client.get('$authServiceBaseUrl/config');
  }

  Future<Response> fetchAllList(
      {int? brandId, int? subId, int offset = 0}) async {
    final branch = (brandId != null) ? '/$brandId' : '';
    final subCar = (subId != null) ? '/$subId' : '';
    return client.get(
        '$authServiceBaseUrl/products$branch$subCar?type=latest?limit=20&offset=$offset');
  }

  Future<Response> fetchVipProduct({int offset = 0, int limit =5}) async {
    return client
        .get('$authServiceBaseUrl/products?limit=$limit&type=vip&offset=$offset');
  }

  Future<Response> detailCar(String id) {
    return client.get('$authServiceBaseUrl/products/details/$id');
  }

  Future<Response> relatedProduct(int branchId) {
    return client.get('$authServiceBaseUrl/related-products/$branchId');
  }

// Showroom

  Future<Response> fetchShowroom({int limit = 10, int offset = 0}) async {
    return client
        .get('$authServiceBaseUrl/showroom?limit=$limit&offset=$offset');
  }

  Future<Response> fetchCarModel({int limit = 12}) async {
    return client.get('$authServiceBaseUrl/hangxe?limit=$limit');
  }

  //blog
  Future<Response> getAllBlog({int limit = 10, int offset = 0}) async {
    return client.get('$authServiceBaseUrl/blog?limit=$limit&offset=$offset');
  }

  //notifications
  Future<Response> getListNotification({int limit = 10, int offset = 0}) async {
    return client
        .get('$authServiceBaseUrl/notifications?limit=$limit&offset=$offset');
  }

  //car company
  Future<Response> getCarCompanyByType(int? typeId) {
    return client
        .get('$authServiceBaseUrl/GroupBrandCar?loaixe=$typeId&limit=50');
  }

  //vehicles
  Future<Response> getListVehicleByCarId({int? brandId}) {
    return client.get('$apiHostReal/dangtin/?GetDongxe&hangxeid=$brandId');
  }

  //vehicles
  Future<Response> getMyPost() {
    return client.get('$apiHostReal/api/?GetData&m=1');
  }

  Future<Response> getInfoPost({int? loaixe}) {
    return client.get('$authServiceBaseUrl/GroupInfoPost?loaixe=$loaixe');
  }

  //images
  Future<Response> uploadImage(File image) async {
    dio.FormData formData = dio.FormData.fromMap({
      'fileupload': await dio.MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });
    return client.post(
      '$apiHostReal/car?op=upload&action=upload',
      data: formData,
    );
  }

  Future<Response> ceateNews(Map<String, dynamic> body) async {
    final FormData formData = new FormData.fromMap(body);
    print(formData);
    return client.post(
      'https://tinbanxe.vn/dangtin?InsertData',
      data: formData,
    );
  }
}
