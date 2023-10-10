import 'package:nutech_flutter_apps/data/model/converter.dart';
import 'package:nutech_flutter_apps/model/meta.dart';
import 'package:flutter/material.dart';
import 'base_response.dart';

class PrimitiveResponseObject<T> extends BaseResponse {
  final T? data;

  PrimitiveResponseObject({
    required int status,
    required String message,
    required String domain,
    this.data,
    required Map<String, dynamic>? errors,
  }) : super(
          status: status,
          message: message,
          // domain: domain,
          errors: errors,
        );

  factory PrimitiveResponseObject.fromJson(Map<String, dynamic> json) {
    return PrimitiveResponseObject<T>(
      status: json["status"] as int,
      message: json["message"] as String,
      domain: json["domain"] as String,
      data: json["results"] != null ? json["results"] as T : null,
      errors: json["errors"] != null
          ? json["errors"] as Map<String, dynamic>
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': this.status,
        'message': this.message,
        // 'domain': this.domain,
        'result': this.data == null ? null : data,
        'errors': this.errors == null ? null : errors,
      };
}

class ResponseNutech<T> extends BaseResponse {
  final T? data;

  ResponseNutech({
    required int status,
    required String message,
    this.data,
  }) : super(status: status, message: message);

  factory ResponseNutech.fromJson(Map<String, dynamic> json) {
    debugPrint('T --> ${T}');
    debugPrint('result --> ${json["data"]}');
    return ResponseNutech<T>(
      status: json["status"] as int,
      message: json["message"] as String,
      data: json["data"] != null
          ? Converter<T>().fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': this.status,
    'message': this.message,
    'data': this.data == null ? null : Converter<T>().toJson(this.data!),
  };

}

class ResponseListNutech<T> extends BaseResponse {
  List<T>? data;

  ResponseListNutech({
    required int status,
    required String message,
    this.data = const [],
  }) : super(status: status, message: message);

  factory ResponseListNutech.fromJson(Map<String, dynamic> json) {
    debugPrint('T --> ${T}');
    debugPrint('result --> ${json["data"]}');
    return ResponseListNutech<T>(
      status: json["status"] as int,
      message: json["message"] as String,
      data: List<T>.from(
          json["data"]?.map((x) => Converter<T>().fromJson(x)) ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': this.status,
    'message': this.message,
    'data': this.data?.map(Converter<T>().toJson).toList(),
  };

}

class ResponseObject<T> extends BaseResponse {
  final T? data;

  ResponseObject({
    required int status,
    required String message,
    required String domain,
    this.data,
  }) : super(status: status, message: message);

  factory ResponseObject.fromJson(Map<String, dynamic> json) {
    debugPrint('T --> ${T}');
    debugPrint('result --> ${json["results"]}');
    return ResponseObject<T>(
      status: json["status"] as int,
      message: json["message"] as String,
      domain: json["domain"] as String,
      data: json["results"] != null
          ? Converter<T>().fromJson(json["results"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': this.status,
        'message': this.message,
        // 'domain': this.domain,
        'result': this.data == null ? null : Converter<T>().toJson(this.data!),
      };
}

class ResponseList<T> extends BaseResponse {
  List<T>? data;
  int? page;
  int? totalPage;
  // Meta? meta;

  ResponseList({
    required int status,
    required String message,
    // required String domain,
    this.data = const [],
    this.page,
    this.totalPage
    // this.meta,
  }) : super(status: status, message: message);

  factory ResponseList.fromJson(Map<String, dynamic> json) {
    debugPrint('result --> ${json["data"]}');
    return ResponseList<T>(
      status: json["status"],
      message: json["message"],
      page: json['page'],
      totalPage: json['total_page'],
      // domain: json["domain"],
      // meta: json["meta"] == null ? null : Meta.fromJson(json['meta']),
      data: List<T>.from(
          json["data"]?.map((x) => Converter<T>().fromJson(x)) ?? []),
      // data: json["results"] != null
      //     ? []
      //     : List<T>.from(
      //         json["results"].map((x) => Converter<T>().fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': this.status,
        'message': this.message,
        'page'    : this.page,
        'total_page' : this.totalPage,
        // 'domain': this.domain,
        // 'meta': this.meta,
        'data': this.data?.map(Converter<T>().toJson).toList(),
      };
}
