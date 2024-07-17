import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/db_provider.dart';
import 'package:fuel_management_app/Controllers/login_provider.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Controllers/trip_provider.dart';
import 'package:fuel_management_app/Model/DBModel.dart';
import 'package:fuel_management_app/UI/login_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'UI/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize sqflite for desktop support
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  // Initialize the database

  await DBModel().intiDataBase();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TripProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DbProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SubProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => OpProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginProvider(),
      ),
    ],
    child: const MyApp(),
  ));
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
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            primaryIconTheme: const IconThemeData(color: Colors.white),
            iconTheme: const IconThemeData(color: Colors.white),
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
      child: const LoginPage(),
    );
  }
}
