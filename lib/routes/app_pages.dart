import 'package:tinbanxe/pages/acount/accountDetail/binding/account_detail_binding.dart';
import 'package:tinbanxe/pages/acount/accountDetail/view/accont_detail.dart';
import 'package:tinbanxe/pages/acount/acount_dashboard/binding/accout_binding.dart';
import 'package:tinbanxe/pages/acount/acount_dashboard/view/information_page.dart';
import 'package:tinbanxe/pages/acount/change_password/binding/change_password_binding.dart';
import 'package:tinbanxe/pages/acount/change_password/view/change_password.dart';
import 'package:tinbanxe/pages/auth/forgot_password/binding/forgot_password_binding.dart';
import 'package:tinbanxe/pages/auth/forgot_password/view/_verify_otp.dart';
import 'package:tinbanxe/pages/auth/forgot_password/view/forgot_password.dart';
import 'package:tinbanxe/pages/auth/forgot_password/view/new_password.dart';
import 'package:tinbanxe/pages/auth/login/binding/login_binding.dart';
import 'package:tinbanxe/pages/auth/login/view/login.dart';
import 'package:tinbanxe/pages/auth/register/binding/register_binding.dart';
import 'package:tinbanxe/pages/auth/register/view/register.dart';
import 'package:tinbanxe/pages/blog/blog_dashboard/binding/blog_binding.dart';
import 'package:tinbanxe/pages/blog/blog_dashboard/view/blog.dart';
import 'package:tinbanxe/pages/favorite/favorite_dashboard/binding/favorite_binding.dart';
import 'package:tinbanxe/pages/home/binding/home_binding.dart';
import 'package:tinbanxe/pages/home/view/home.dart';
import 'package:tinbanxe/pages/myNews/binding/my_post_binding.dart';
import 'package:tinbanxe/pages/myNews/view/my_post_view.dart';
import 'package:tinbanxe/pages/notification/notification_dashboard/binding/notification_binding.dart';
import 'package:tinbanxe/pages/notification/notification_dashboard/view/notification_view.dart';
import 'package:tinbanxe/pages/post/post_dashboard/binding/post_binding.dart';
import 'package:tinbanxe/pages/post/post_dashboard/view/post_create_page.dart';
import 'package:tinbanxe/pages/product/detail_product/binding/detail_product_binding.dart';
import 'package:tinbanxe/pages/product/detail_product/view/detail_product_view.dart';
import 'package:tinbanxe/pages/product/product_dashboard/binding/product_binding.dart';
import 'package:tinbanxe/pages/product/product_dashboard/view/product_view.dart';
import 'package:tinbanxe/pages/splash/view/splash.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => SplashPage()),
    GetPage(name: Routes.HOME, page: () => HomePage(), bindings: [
      HomeBinding(),
      ProductBinding(),
      FavoriteBinding(),
      AccountBinding(),
      BlogBinding(),
    ]),
    GetPage(
        name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
        name: Routes.PRODUCT,
        page: () => ProductPage(),
        binding: ProductBinding()),
    GetPage(
        name: Routes.DETAIL_CAR,
        page: () => DetailProductPage(),
        binding: DetailCarBinding()),
    GetPage(
        name: Routes.FORGOT_PASSWORD,
        page: () => ForgotPasswordPage(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: Routes.VERIFY_OTP,
        page: () => VerifyOTP(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: Routes.NEW_PASS,
        page: () => NewPasswordPage(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: Routes.PROFILE,
        page: () => AccountDetailPage(),
        binding: AccountDetailBinding()),
    GetPage(
        name: Routes.NOTIFICATION,
        page: () => NotificationPage(),
        binding: NotificationBinding()),
    GetPage(
        name: Routes.CHANGE_PASS,
        page: () => ChangePasswordPage(),
        binding: ChangePasswordBinding()),
    GetPage(
        name: Routes.POST_CREATE,
        page: () => PostCreatePage(),
        binding: PostBinding()),
    GetPage(
        name: Routes.MyPostView,
        page: () => MyPostView(),
        binding: MyPostBinding()),
    GetPage(
        name: Routes.ALL_BLOG, page: () => BlogPage(), binding: BlogBinding()),
  ];
}
