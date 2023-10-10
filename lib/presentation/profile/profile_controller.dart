import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:nutech_flutter_apps/data/remote/api_services.dart';
import 'package:nutech_flutter_apps/data/remote/base/base_controller.dart';
import 'package:nutech_flutter_apps/data/remote/errorhandler/error_handler.dart';
import 'package:nutech_flutter_apps/data/remote/image_uploader.dart';
import 'package:nutech_flutter_apps/model/user.dart';
import 'package:nutech_flutter_apps/presentation/auth/auth_controller.dart';

class ProfileController extends BaseController{
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
  final AuthController authController = AuthController.find;
  final ImagePicker picker = ImagePicker();
  String? imagePath;
  XFile? image;

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> pickImageFromGalerry() async {
    XFile? imageTemp = await picker.pickImage(source: ImageSource.gallery);
    imagePath = imageTemp?.path;
    if (imageTemp != null) {
      File fileImage = File(imageTemp.path);
      await FlutterImageCompress.compressAndGetFile(
        fileImage.absolute.path,
        fileImage.path + 'compressed.jpeg',
        minHeight: 600,
        minWidth: 600,
        quality: 70
      ).then((value) {
        image = value;
        update();
      });
      imagePath = image?.name;
      setParammageUploader(image?.path ?? "");
    }
    update();
  }

  Future<void> pickImageFromCamera() async {
    XFile? imageTemp = await picker.pickImage(source: ImageSource.camera);
    imagePath = imageTemp?.path;
    if (imageTemp != null) {
      File fileImage = File(imageTemp.path);
      await FlutterImageCompress.compressAndGetFile(
        fileImage.absolute.path,
        fileImage.path + 'compressed.jpeg',
        minHeight: 600,
        minWidth: 600,
        quality: 70
      ).then((value) async {
        image = value;
        update();
      });
      imagePath = image?.name;
      setParammageUploader(image?.path ?? "");
    }
    update();
  }

  void setParammageUploader(String path) async {
  try {
    String? token = await authController.secureStorage.getToken();
    if (token != null) {
      await uploadImage(path, token);
    } else {
      finishLoadData(errorMessage: "Token tidak tersedia.");
      debugPrint("Token tidak tersedia.");
    }
  } catch (error) {
    finishLoadData(errorMessage: error.toString());
    debugPrint("error : $error");
  }
}

Future<void> uploadImage(String imagePath, String token) async {
  try {
    authController.setForceEdit();
    await ImageUploader.uploadImage(imagePath, token);
    await authController.secureStorage.getToken().then((tokenAuth) {
      authController.saveAuthData(
        user: authController.user ?? User(), 
        token: tokenAuth ?? "",
      );
      authController.onInit();
    });
    saveCacheAndFinish();
  } catch (error) {
    finishLoadData(errorMessage: error.toString());
    // debugPrint("error : $error");
  }
}


  Future<void> updateProfile() async {
    await RestClient.create().then((value) 
    => value
      .putProfile(
        formKey.currentState?.value
      )
      .validateData()
      .then((value) async{
        await authController.secureStorage.getToken().then((tokenAuth) {
          authController.saveAuthData(
            user: authController.user ?? User(), 
            token: tokenAuth ?? "",
          );
          authController.setForceEdit();
          authController.onInit();
        });
      }).handleError((onError){
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
        return throw onError;
      })
    );
  }

}