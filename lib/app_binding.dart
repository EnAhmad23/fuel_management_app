import 'package:get/get.dart';
import 'Controllers/consumer_controller.dart';
import 'Controllers/db_controller.dart';
import 'Controllers/login_controller.dart';
import 'Controllers/op_controller.dart';
import 'Controllers/sub_controller.dart';
import 'Controllers/trip_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConController>(() => ConController(), fenix: true);
    Get.lazyPut<DbController>(() => DbController(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<OpController>(() => OpController(), fenix: true);
    Get.lazyPut<SubController>(() => SubController(), fenix: true);
    Get.lazyPut<TripController>(() => TripController(), fenix: true);
  }
}
