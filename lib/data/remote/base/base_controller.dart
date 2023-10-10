import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/data/local/storage/storage_manager.dart';
import 'package:nutech_flutter_apps/data/remote/base/base_refresher_status.dart';
import 'package:nutech_flutter_apps/data/model/converter.dart';

abstract class BaseController<T> extends GetxController {
  StorageManager storage = StorageManager();

  T? dataObj;
  List<T> dataList = [];

  String message = "";

  get statusData;
  bool get isUsingList => statusData is List;
  String get storageName;
  void refreshPage();
  void loadNextPage();

  Rx<RefresherStatus> status = Rx(RefresherStatus.initial);

  bool get isInitial => status.value == RefresherStatus.initial;

  /// **Note:**
  /// loading with probably data is not empty
  bool get isLoading => status.value == RefresherStatus.loading;

  /// **Note:**
  /// loading with no data from the beginning
  bool get isShimmering => isLoading && isEmptyData;

  bool get isEmptyData => isUsingList ? dataList.isEmpty : dataObj == null;
  bool get isSuccess => status.value == RefresherStatus.success;
  bool get isError => status.value == RefresherStatus.failed && isEmptyData;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// **NOTE:**
  /// make sure you call this method at initial state, before you call method [saveCacheAndFinish]
  Future<void> getCache({String id = '0'}) async {
    var cache = storage.get(storageName);
    if (storage.has(storageName)) {
      if (cache != null && cache.toString().isNotEmpty) {
        if (isUsingList) {
          _setFinishCallbacks(
              list: List<T>.from(
                  json.decode(cache).map((x) => Converter<T>().fromJson(x))));
        } else {
          if (id == getId(cache)) {
            _setFinishCallbacks(data: Converter<T>().fromJson(cache));
          }
        }
      }
    }
  }

  String getId(Map<String, dynamic> cache) {
    return (cache['id'] ?? '0').toString();
  }

  /// **NOTE:**
  /// call this to finish the load data,
  /// don't need to call [finishLoadData] anymore
  Future<void> saveCacheAndFinish(
      {List<T>? list, T? data, int page = 1}) async {
    await storage.write(
        storageName,
        isUsingList
            ? json.encode(list ?? [])
            : (data != null ? Converter<T>().toJson(data) : ""));
    finishLoadData(list: list, data: data, page: page);
  }

  /// **Note:**
  /// the state will go to error state if the [errorMessage] is not null,
  /// call this [finishLoadData] instead [saveCacheAndFinish] if the data is not require to saved in local data
  void finishLoadData({
    String errorMessage = "",
    List<T>? list = const [],
    T? data,
    int page = 1,
  }) {
    // this.page(page);
    if (errorMessage.isNotEmpty) {
      _setErrorStatus(errorMessage);
    } else {
      _setFinishCallbacks(list: list, data: data);
    }
    update();
  }

  /// **NOTE:**
  /// call this to change state to Loading State
  void loadingState() {
    status.value = RefresherStatus.loading;
    update();
  }

  /// **NOTE:**
  /// call this to change state to Success State
  successState() {
    status.value = RefresherStatus.success;
    update();
  }

  /// **NOTE:**
  /// call this to change state to Success State
  emptyState() {
    status.value = RefresherStatus.empty;
    update();
  }

  /// **NOTE:**
  /// call this to change state to Error State
  void errorState() {
    status.value = RefresherStatus.empty;
    update();
  }

  void _addData(List<T> data) {
    // if (page.value == 1) {
    // }
      dataList.clear();
    if (data.isNotEmpty) {
      dataList.addAll(data);
    } else {
      if (isUsingList) {
        emptyState();
      }
    }
    // hasNext.value = !(data.length < perPage.value);
  }

  void _setData(T? data) {
    if (data != null) {
      dataObj = data;
    } else if (!isUsingList) {
      emptyState();
    }
  }

  void _setFinishCallbacks({List<T>? list, T? data}) {
    _addData(list ?? []);
    _setData(data);
    successState();
    _finishRefresh();
  }

  void _setErrorStatus(String message) {
    errorState();
    message = (message.isNotEmpty) ? message : 'Terjadi kesalahan';
    Get.snackbar('Terjadi kesalahan', message.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
    _finishRefresh();
  }

  void _finishRefresh() {
    if (refreshController.isRefresh) {
      refreshController.refreshCompleted();
    }
    if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
    update();
  }

  Future<void> showLoading({String? message}) async {
    if (Get.overlayContext != null && Get.isOverlaysClosed) {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [CircularProgressIndicator()],
              ),
            ),
          ),
        ),
      );
    }
  }

  void dismissLoading() {
    if (Get.overlayContext != null) {
      Navigator.of(Get.overlayContext!).pop();
    }
  }

  void showError(String message) {
    Get.snackbar('txt_error_title'.tr, message.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  void showLoginError(String message) {
    Get.snackbar(message.toString(), 'txt_invalid_login'.tr,
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  void showNotif(String message) {
    Get.snackbar('txt_success_notif'.tr, message.toString(),
        backgroundColor: AppColors.successMain, colorText: Colors.white);
  }
}
