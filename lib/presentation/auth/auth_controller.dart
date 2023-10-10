import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutech_flutter_apps/data/local/storage/storage_constants.dart';
import 'package:nutech_flutter_apps/data/local/storage/storage_manager.dart';
import 'package:nutech_flutter_apps/data/remote/api_services.dart';
import 'package:nutech_flutter_apps/data/remote/errorhandler/error_handler.dart';
import 'package:nutech_flutter_apps/model/user.dart';
import 'package:nutech_flutter_apps/routes/page_names.dart';
import 'package:nutech_flutter_apps/data/local/secure/secure_storage_manager.dart';
import 'auth_state.dart';

class AuthController extends GetxController {
  static AuthController find = Get.find();
  Rxn<AuthState> authState = Rxn<AuthState>();
  int tabindex = 0;
  String balance = '0';

  Stream<AuthState?> get stream => authState.stream;
  AuthState? get state => authState.value;

  var storage = StorageManager();
  var secureStorage = SecureStorageManager();

  User? get user {
    final user = storage.get<Map<String, dynamic>>(StorageName.USERS);
    if (user != null) {
      return User.fromJson(user);
    } else {
      return null;
    }
  }

  @override
  void onInit() async {
    authState.value = const AuthState(appStatus: AppType.INITIAL);
    super.onInit();
  }

  @override
  void onReady() async {
    ever(authState, authChanged);
    authChanged(state);
    super.onReady();
  }

  Future<void> authChanged(AuthState? state) async {
    if (state?.appStatus == AppType.INITIAL) {
      await setup();
      await checkToken();
    } else if (state?.appStatus == AppType.UNAUTHENTICATED) {
      await clearData();
      await Future.delayed(const Duration(seconds: 3));
      Get.offAllNamed(PageName.LOGIN);
    } else if (state?.appStatus == AppType.AUTHENTICATED) {
      await getUser();
      Get.offAllNamed(PageName.NAVBAR);
    } else {
      Get.toNamed(PageName.LOADER);
    }
    update();
  }

  Future<void> checkToken() async {
    if (storage.has(StorageName.USERS)) {
      setAuth();
    } else {
      signOut();
    }
  }

  Future<void> clearData() async {
    storage.clearAll();
    await secureStorage.setToken(value: '');
  }

  Future<void> saveAuthData({
    required User user,
    required String token,
  }) async {
    // await NotificationHandler.setExternalId(user.id);
    await storage.write(StorageName.USERS, user.toJson());
    await secureStorage.setToken(value: token);
    setAuthValidate(user);
  }

  void setAuthValidate(User user) {
    if (user.validate()) {
      setAuth();
    } else {
      // setForceEditProfile();
    }
  }

  void setForceEdit() =>
      authState.value = AuthState(appStatus: AppType.LOAD);

  Future<void> signOut() async {
    await secureStorage.setToken(value: '');
    await storage.clearAll();
    tabindex = 0;
    balance = '0';
    authState.value = const AuthState(appStatus: AppType.UNAUTHENTICATED);
  }

  void setAuth() {
    authState.value = const AuthState(appStatus: AppType.AUTHENTICATED);
  }

  Future<void> setup() async {
    final firstInstall = storage.get<bool>(StorageName.FIRST_INSTALL) ?? false;
    if (firstInstall) {
      await secureStorage.setToken(value: '');
      await storage.write(StorageName.FIRST_INSTALL, false);
    }
  }

  Future<void> getUser() async {
    await RestClient.create().then((value) 
    => value
      .getUser()
      .validateData()
      .then((value) async{
        var token = '';
        await secureStorage.getToken().then((v) => token = v ?? '');
        saveAuthData(
          user: value.data ?? User(), 
          token: token
        );
      }).handleError((onError){
        debugPrint("error : " + onError.toString());
        return throw onError;
      })
    );
  }
}
