// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:nutech_flutter_apps/data/local/storage/storage_constants.dart';
import 'package:nutech_flutter_apps/data/local/storage/storage_manager.dart';
import 'package:nutech_flutter_apps/data/remote/api_services.dart';
import 'package:nutech_flutter_apps/data/remote/base/base_controller.dart';
import 'package:nutech_flutter_apps/data/remote/errorhandler/error_handler.dart';
import 'package:nutech_flutter_apps/model/balance.dart';
import 'package:nutech_flutter_apps/model/carousel.dart';
import 'package:nutech_flutter_apps/model/service_menu.dart';
import 'package:nutech_flutter_apps/presentation/auth/auth_controller.dart';
import 'package:nutech_flutter_apps/presentation/navbar/navBar_controller.dart';
import 'package:nutech_flutter_apps/presentation/profile/profile_controller.dart';
import 'package:nutech_flutter_apps/presentation/topup/topup_controller.dart';
import 'package:nutech_flutter_apps/presentation/transaction/transaction_controller.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/utils/dialog/modal_dialog.dart';

class HomeController extends BaseController<ServiceMenu> {
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
  get statusData => dataObj;

  @override
  // TODO: implement storageName
  String get storageName => StorageName.SERVICEMENU;

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final AuthController authController = AuthController.find;
  var storage = StorageManager();

  List<Carousel> carouselListItems = [];
  bool shownominal = false;

  @override
  void onInit() async {
    await getSaldo();
    await getBanner();
    await getMenuItems();
    super.onInit();
  }

  void changeViewSaldo(){
    if(shownominal){
      shownominal = false;
    } else {
      shownominal = true;
    }
    update();
  }

  void modalValidation(BuildContext context, int index){
    if(formKey.currentState != null){
      formKey.currentState?.save();
      ModalDialog.YYDialogAttention(
        context, 
        content_top: "Pembayaran untuk ${dataList[index].serviceName} senilai",
        content_bold: "${formKey.currentState?.value['service_code']} ?",
        content_button: "Ya, Lanjutkan Top Up",
        buttonNext: (){
          Get.back();
          submitPayment(context, index);
        },
        buttonClose: (){
          Get.back();
        }
      );
    }
  }

  void submitPayment(BuildContext context, int index){
    if (formKey.currentState != null && formKey.currentState!.saveAndValidate()){
      loadingState();
      payment(context, index);
    } else {
      errorValidate(context, index: index);
    }
  }

  void errorValidate(BuildContext context, {String errorText = 'Silahkan Coba lagi!', int index = 0}){
    formKey.currentState?.fields.forEach((key, value) {
      ModalDialog.YYDialogError(
        context,
        content_top: 'Pembayaran ${dataList[index].serviceName} sebesar',
        content_bold : 'Rp ${formatNumber(dataList[index].serviceTariff.toString())}',
        content_bottom: 'Gagal',
        content_soft : value.errorText ?? errorText,
        content_button: 'Kembali Ke Beranda',
        buttonAction: (){
          Get.back();
        }
      );
    });
  }

  Future<void> getBanner() async {
    await RestClient.create().then((value) 
    => value
      .getCarousel()
      .validateData()
      .then((value) async{
        await storage.write(StorageName.CAROUSEL, value.data);
        carouselListItems.addAll(storage.get(StorageName.CAROUSEL));
        update();
      }).handleError((onError){
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
        return throw onError;
      })
    );
  }

  Future<void> getMenuItems() async {
    await RestClient.create().then((value) 
    => value
      .getServiceMenu()
      .validateData()
      .then((value) async{
        await saveCacheAndFinish(list: value.data!);
        update();
      }).handleError((onError){
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
        return throw onError;
      })
    );
  }

  Future<void> getSaldo() async {
    await RestClient.create().then((value) 
    => value
      .getBalance()
      .validateData()
      .then((value) async{
        String balance = formatNumber("${value.data?.balance ?? 0}");
        await storage.write(StorageName.BALANCE, balance);
        authController.balance = await storage.get(StorageName.BALANCE);
        update();
      }).handleError((onError){
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
        return throw onError;
      })
    );
  }

  Future<void> payment(BuildContext context, int index) async {
    await RestClient.create().then((value) 
    => value
      .postPayment({
        "service_code": dataList[index].serviceCode
      })
      .validateData()
      .then((value) async{
        String balance = formatNumber("${ convertToInteger(authController.balance) - (dataList[index].serviceTariff ?? 0) }");
        await storage.write(StorageName.BALANCE, balance);
        authController.balance = await storage.get(StorageName.BALANCE);
        ModalDialog.YYDialogSuccess(
          context,
          content_top: 'Pembayaran ${dataList[index].serviceName} sebesar',
          content_bold : 'Rp ${formatNumber(dataList[index].serviceTariff.toString())}',
          content_bottom: 'berhasil!',
          content_button: 'Kembali Ke Beranda',
          buttonAction: (){
            authController.setForceEdit();
            authController.onInit();
          }
        );
      }).handleError((onError){
        errorValidate(context, index: index);
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

  int convertToInteger(String input) {
    String cleanedString = input.replaceAll('Rp', '').replaceAll('.', '').replaceAll(' ', '');
    int? result = int.tryParse(cleanedString);

    return result ?? 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    HomeController().dispose();
    TopUpController().dispose();
    ProfileController().dispose();
    TransactionController().dispose();
    super.dispose();
  }

}