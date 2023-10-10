import 'package:get/get.dart';
import 'package:nutech_flutter_apps/data/remote/base/base_controller.dart';
import 'package:nutech_flutter_apps/presentation/auth/auth_controller.dart';

class NavBarController extends BaseController {
  
  Rxn<int> tabIndex = Rxn();
  final AuthController authController = AuthController.find;
  
  void changeTabMenu(int index){
    tabIndex.value = index;
    authController.tabindex = index;
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    tabIndex.value = authController.tabindex;
    super.onInit();
  }
  
  @override
  void loadNextPage() {
    // TODO: implement loadNextPage
  }
  
  @override
  void refreshPage() {
    // TODO: implement refreshPage
  }
  
  @override
  // TODO: implement statusData
  get statusData => throw UnimplementedError();
  
  @override
  // TODO: implement storageName
  String get storageName => throw UnimplementedError();

}