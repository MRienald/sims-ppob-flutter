import 'dart:core';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import 'package:nutech_flutter_apps/data/local/storage/storage_constants.dart';

class StorageManager {
  final _box = GetStorage(StorageName.STORAGE_NAME);

  Future<void> write(String name, dynamic value) async {
    return _box.write(name, value);
  }

  Future<void> delete(String name) async {
    return _box.remove(name);
  }

  T? get<T>(String name) {
    return _box.read<T>(name);
  }

  bool has(String name) {
    return _box.hasData(name);
  }

  String encodeList<T>(List<T> datas) {
    return json.encode(datas);
  }

  Future<void> clearAll() async {
    return _box.erase();
  }
}
