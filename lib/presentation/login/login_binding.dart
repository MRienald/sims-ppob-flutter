import 'package:get/get.dart';
import 'package:nutech_flutter_apps/presentation/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}