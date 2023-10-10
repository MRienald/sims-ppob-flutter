// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:nutech_flutter_apps/data/local/storage/storage_constants.dart';
import 'package:nutech_flutter_apps/data/remote/api_services.dart';
import 'package:nutech_flutter_apps/data/remote/base/base_controller.dart';
import 'package:nutech_flutter_apps/data/remote/errorhandler/error_handler.dart';
import 'package:nutech_flutter_apps/presentation/auth/auth_controller.dart';
import 'package:nutech_flutter_apps/utils/dialog/modal_dialog.dart';

class TopUpController extends BaseController {
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

  
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
  }

  final AuthController authController = AuthController.find;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  bool shownominal = false;
  
  Map<String, bool> nominalItems = {
    "Rp10.000" : false, 
    "Rp20.000" : false, 
    "Rp50.000" : false, 
    "Rp100.000" : false, 
    "Rp250.000" : false, 
    "Rp500.000" : false,
  };
  int nominal_selected = 0;

  void chooseNominalItems (String key){
    nominalItems = {
      "Rp10.000" : false, 
      "Rp20.000" : false, 
      "Rp50.000" : false, 
      "Rp100.000" : false, 
      "Rp250.000" : false, 
      "Rp500.000" : false,
    };
    nominalItems[key] = true;
    nominal_selected = int.parse(key.replaceAll(RegExp(r'[^0-9]'), ''));
    formKey.currentState?.fields['top_up_amount']?.didChange(key);
    formKey.currentState?.save();
    update();
  }

  void changeViewSaldo(){
    if(shownominal){
      shownominal = false;
    } else {
      shownominal = true;
    }
    update();
  }

  int convertToInteger(String input) {
    String cleanedString = input.replaceAll('Rp', '').replaceAll('.', '');
    int? result = int.tryParse(cleanedString);

    return result ?? 0;
  }

  void modalValidation(BuildContext context){
    if(formKey.currentState != null){
      formKey.currentState?.save();
      ModalDialog.YYDialogAttention(
        context, 
        content_top: "Anda yakin untuk Top Up Sebesar",
        content_bold: "${formKey.currentState?.value['top_up_amount']} ?",
        content_button: "Ya, Lanjutkan Top Up",
        buttonNext: (){
          Get.back();
          submitTopUp(context);
        },
        buttonClose: (){
          Get.back();
        }
      );
    }
  }

  void submitTopUp(BuildContext context){
    if (formKey.currentState != null && formKey.currentState!.saveAndValidate()){
      loadingState();
      topUpAmount(context);
    } else {
      errorValidate(context);
    }
  }

  void errorValidate(BuildContext context, {String errorText = 'Silahkan Coba lagi!'}){
    formKey.currentState?.fields.forEach((key, value) {
      ModalDialog.YYDialogError(
        context,
        content_top: 'Top Up sebesar',
        content_bold : value.value,
        content_bottom: 'Gagal',
        content_soft : value.errorText ?? errorText,
        content_button: 'Kembali Ke Beranda',
        buttonAction: (){
          Get.back();
        }
      );
    });
  }

  Future<void> topUpAmount(BuildContext context) async {
    await RestClient.create().then((value) 
    => value
      .topUpBalance({
        'top_up_amount': convertToInteger(formKey.currentState?.value['top_up_amount'])
      })
      .then((value) async{
        String balance = formatNumber("${value.data?.balance ?? 0}");
        await storage.write(StorageName.BALANCE, balance);
        authController.balance = await storage.get(StorageName.BALANCE);
        ModalDialog.YYDialogSuccess(
          context,
          content_top: 'Top Up sebesar',
          content_bold : formKey.currentState?.value['top_up_amount'],
          content_bottom: 'berhasil!',
          content_button: 'Kembali Ke Beranda',
          buttonAction: (){
            authController.setForceEdit();
            authController.onInit();
          }
        );
      }).handleError((onError){
        errorValidate(context);
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
        return throw onError;
      })
    );
  }

  String formatNumber(String number) {
    int parsedNumber = int.parse(number);
    String formattedNumber = NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: '').format(parsedNumber);
    formattedNumber = formattedNumber.replaceAll('\$', '');

    return formattedNumber;
  }

}