import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:logger/logger.dart';
import 'package:nutech_flutter_apps/data/remote/api_services.dart';
import 'package:nutech_flutter_apps/data/remote/base/base_controller.dart';
import 'package:nutech_flutter_apps/data/remote/errorhandler/error_handler.dart';
import 'package:nutech_flutter_apps/model/user.dart';
import 'package:nutech_flutter_apps/presentation/auth/auth_controller.dart';

class LoginController extends BaseController<User>{
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

  final AuthController authController = AuthController.find;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  bool hidePasswod = true;

  void hideOrShowPassword(){
    if(hidePasswod){
      hidePasswod = false;
    } else {
      hidePasswod = true;
    }
    update();
  }

  Future<void> getUser() async {
    await RestClient.create().then((value) 
    => value
      .getUser()
      .validateData()
      .then((value) async{
        var token = '';
        await authController.secureStorage.getToken().then((v) => token = v ?? '');
        authController.saveAuthData(
          user: value.data ?? User(), 
          token: token
        );
      }).handleError((onError){
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
        return throw onError;
      })
    );
  }

  Future<void> login() async {
    await RestClient.create().then((value) 
    => value
      .login({
        "email": formKey.currentState?.value['username'],
        "password": formKey.currentState?.value['password']
      })
      .validateData()
      .then((value) async{
        Logger().e(value.message);
        await authController.saveAuthData(
          user: User(), 
          token: value.data?.token ?? ""
        );
        getUser();
      }).handleError((onError){
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
        return throw onError;
      })
    );
  }

}