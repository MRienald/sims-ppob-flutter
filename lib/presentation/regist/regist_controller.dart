import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nutech_flutter_apps/data/remote/api_services.dart';
import 'package:nutech_flutter_apps/data/remote/base/base_controller.dart';
import 'package:nutech_flutter_apps/data/remote/errorhandler/error_handler.dart';
import 'package:nutech_flutter_apps/model/user.dart';
import 'package:nutech_flutter_apps/routes/page_names.dart';

class RegistController extends BaseController {
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

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  List<bool> hidePasswod = [true, true];

  void hideOrShowPassword(int index){
    if(hidePasswod[index]){
      hidePasswod[index] = false;
    } else {
      hidePasswod[index] = true;
    }
    update();
  }

  Future<void> registAccount() async {
    await RestClient.create().then((value) 
    => value
      .postRegist(UserAccount(
        email: formKey.currentState?.value['username'],
        firstName: formKey.currentState?.value['firstname'],
        lastName: formKey.currentState?.value['lastname'],
        password: formKey.currentState?.value['password'],
      ))
      .then((value) async{
        Get.offAndToNamed(PageName.LOGIN);
      }).handleError((onError){
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
        return throw onError;
      })
    );
  }

}