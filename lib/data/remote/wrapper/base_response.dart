import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'message')
  String message;
  // @JsonKey(name: 'domain')
  // String domain;
  @JsonKey(name: 'errors')
  Map<String, dynamic>? errors;

  BaseResponse({
    required this.status,
    required this.message,
    // required this.domain,
    this.errors,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        status: json["status"],
        message: json["message"],
        // domain: json["domain"],
        errors: json["errors"],
      );

  Map<dynamic, dynamic> toJson() => <String, dynamic>{
        'status': this.status,
        'message': this.message,
        'errors': this.errors,
      };
}
