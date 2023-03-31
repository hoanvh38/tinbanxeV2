import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tinbanxe/constants/config_constant.dart';
import 'package:tinbanxe/controllers/theme_controller.dart';
import 'package:tinbanxe/i18n/translation_service.dart';
import 'package:tinbanxe/models/banner_model.dart';
import 'package:tinbanxe/models/config_model.dart';
import 'package:tinbanxe/models/user_model.dart';
import 'package:tinbanxe/repositories/authenticate_client.dart';
import 'package:tinbanxe/routes/app_pages.dart';
import 'package:tinbanxe/utils/error_capture_util.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:statusbarz/statusbarz.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tinbanxe/values/style.dart';

import 'controllers/life_cycle_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    reportError(details.exception, details.stack ?? StackTrace.empty);
    return Container();
  };

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ConfigModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(BannerModelAdapter());
  await Hive.openBox<ConfigModel>(BOX_CONFIG);
  await Hive.openBox<UserModel>(BOX_USER);
  await Hive.openBox<BannerModel>(BOX_SYSTEM_BANNER);
  // //
  Get.put(LifeCycleController());
  Get.lazyPut<ThemeController>(() => ThemeController(client: AuthenticateClient()));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await SentryFlutter.init(
          (options) {
        options.dsn =
        'https://88992a05f83541e4a213e364c398bc94@o974112.ingest.sentry.io/6546943';
      },
      appRunner:
          () => // Run the whole app in a zone to capture all uncaught errors.
      runZonedGuarded<Future<void>>(() async {
        await configureSentryScope();
        await ThemeController.to.getThemeMode();

        runApp(
          OverlaySupport(
            child: StatusbarzCapturer(
              child: GetMaterialApp(
                  title: 'Tin Bán Xe',
                  theme: Style.lightTheme,
                  darkTheme: Style.lightTheme,
                  themeMode: ThemeController.to.themeMode,
                  debugShowCheckedModeBanner: false,
                  defaultTransition: Transition.rightToLeft,
                  locale: TranslationService.locale,
                  fallbackLocale: TranslationService.fallbackLocale,
                  translations: TranslationService(),
                  initialRoute: AppPages.INITIAL,
                  getPages: AppPages.routes,
                  navigatorObservers: kDebugMode
                      ? [
                    Statusbarz.instance.observer,
                  ]
                      : [
                    SentryNavigatorObserver(),
                    Statusbarz.instance.observer,
                  ],
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale('vi'),
                  ],
                  onReady: () {
                    // FcmService().configureSelectNotificationSubject(
                    //     Get.context!, () {});
                  },
                  onDispose: () async {
                    // await Hive.box(BOX_USER).close();
                    // await Hive.box(BOX_CONFIG).close();
                    // await Hive.box(BOX_SYSTEM_CONFIG).close();
                    await Hive.close();
                  }),
            ),
          ),
        );
      }, (Object error, StackTrace stackTrace) async {
        await reportError(error, stackTrace);
      }),
    );
  });
}

