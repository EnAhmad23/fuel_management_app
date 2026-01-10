import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fuel_management_app/controllers/db_controller.dart';
import 'package:fuel_management_app/controllers/login_controller.dart';
import 'package:fuel_management_app/controllers/op_controller.dart';
import 'package:fuel_management_app/controllers/sub_controller.dart';
import 'package:fuel_management_app/controllers/trip_controller.dart';
import 'package:fuel_management_app/models/DBModel.dart';
import 'package:fuel_management_app/views/screens/home_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';
import 'core/constant/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize sqflite for desktop support
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  // Initialize the database

  await DBModel().intiDataBase();
  await DBModel().canselCloseMonth();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.maximize();
    windowManager.show();
  });
  // Initialize GetX controllers
  Get.put(TripController());
  Get.put(DbController());
  Get.put(SubController());
  Get.put(OpController());
  Get.put(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1265.6, 684.8),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.background),
            primaryIconTheme: const IconThemeData(color: AppColors.icon),
            iconTheme: const IconThemeData(color: AppColors.icon),
            fontFamily: 'Calibri',
            // iconTheme: const IconThemeData(color: Colors.white),
            textTheme: TextTheme(
              bodyLarge:
                  TextStyle(fontSize: 25.0.sp, fontWeight: FontWeight.w700),
              bodyMedium:
                  TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.w400),
              bodySmall:
                  TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.w700),
            ),
          ),
          home: child,
        );
      },
      child: const HomePage(),
    );
  }
}
