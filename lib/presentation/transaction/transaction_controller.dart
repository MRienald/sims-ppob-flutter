import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nutech_flutter_apps/data/local/storage/storage_constants.dart';
import 'package:nutech_flutter_apps/data/remote/api_services.dart';
import 'package:nutech_flutter_apps/data/remote/base/base_controller.dart';
import 'package:nutech_flutter_apps/data/remote/errorhandler/error_handler.dart';
import 'package:nutech_flutter_apps/model/transaction_history.dart';
import 'package:nutech_flutter_apps/presentation/auth/auth_controller.dart';

class TransactionController extends BaseController<Record> {
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
  get statusData => dataList;

  @override
  // TODO: implement storageName
  String get storageName => StorageName.HISTORYLIST;

  int listviewLenght = 5;
  bool shownominal = false;
  List<String> formattedDate = [];
  List<String> formattedDateTime = [];
  final AuthController authController = AuthController.find;

  @override
  void onInit() async {
    // TODO: implement onInit
    loadingState();
    await getTransactionList(listviewLenght);
    super.onInit();
  }

  Future<void> showMoreTransaction() async {
    listviewLenght = listviewLenght + 5;
    await getTransactionList(listviewLenght);
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

  String formatNumber(String number) {
    int parsedNumber = int.parse(number);
    String formattedNumber = NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: '').format(parsedNumber);
    formattedNumber = formattedNumber.replaceAll('\$', '');

    return formattedNumber;
  }

  String formatDate(DateTime date) {
    String formattedDate = DateFormat('dd MMMM yyyy', 'id').format(date);
    return formattedDate;
  }

  String formatDateTime(DateTime inputDate) {
    DateTime wibTime = inputDate.add(Duration(hours: 7));
    String formattedDate = "${wibTime.hour}:${wibTime.minute.toString().padLeft(2, '0')} WIB";

    return formattedDate;
  }

  Future<void> initDateTime(DateTime inputDate) async {
    initializeDateFormatting('id_ID', null).then((_) {
      formattedDate.add(formatDate(inputDate));
      formattedDateTime.add(formatDateTime(inputDate));
      update();
    });
  }

  Future<void> getTransactionList(int limit , {int offset = 0}) async {
    loadingState();
    await RestClient.create().then((value) 
    => value
      .getTransactionHistory(
        offset,
        limit,
      )
      .validateData()
      .then((value) async{
        if(value.data?.records != null && value.data?.records != []){
          List<Record> tempList = List<Record>.from(value.data!.records!);
          tempList.sort((a, b) => b.createdOn!.compareTo(a.createdOn!));
          for (var element in tempList) {
            await initDateTime(element.createdOn ?? DateTime.now());
          }
          saveCacheAndFinish(list: tempList);
          update();
        }
      }).handleError((onError){
        finishLoadData(errorMessage: onError.toString());
        debugPrint("error : " + onError.toString());
        return throw onError;
      })
    );
  }

}