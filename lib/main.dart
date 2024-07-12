import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'common/providers/local/cache_provider.dart';
import 'common/providers/remote/api_provider.dart';
import 'common/routers/app_router.dart';
import 'common/lang/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await CacheProvider.init();
  ApiProvider.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) => GetMaterialApp(
        // scrollBehavior: MyBehavior(),
        debugShowCheckedModeBanner: false,
        // theme: AppTheme.getAppTheme(context),
        getPages: AppRoute.pages,
        locale: CacheProvider.getAppLocale() == null
            ? const Locale("ar")
            : Locale(CacheProvider.getAppLocale()),
        translations: AppTranslations(),
        initialRoute: AppRoute.loginPageUrl,
      ),
    );
  }
}
