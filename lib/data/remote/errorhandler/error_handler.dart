import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:nutech_flutter_apps/data/remote/errorhandler/network_exception.dart';
import 'package:nutech_flutter_apps/data/remote/wrapper/api_response.dart';
import 'package:nutech_flutter_apps/data/remote/wrapper/base_response.dart';
// import 'package:nutech_flutter_apps/feature/auth/auth_controller.dart';

class ErrorHandler {
  static NetworkExceptions getDioException(error, stackTrace) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.connectTimeout:
              networkExceptions = NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.response:
              switch (error.response?.statusCode) {
                case 400:
                  networkExceptions = NetworkExceptions.badRequest();
                  break;
                case 401:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 403:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 404:
                  networkExceptions = NetworkExceptions.notFound("Not found");
                  break;
                case 409:
                  networkExceptions = NetworkExceptions.conflict();
                  break;
                case 408:
                  networkExceptions = NetworkExceptions.requestTimeout();
                  break;
                case 422:
                  String message = 'Invalid Data';
                  if (error.response?.data['errors'] != null) {
                    message = '';
                    var rest = jsonEncode(error.response?.data ?? {});
                    Map<String, dynamic> res = jsonDecode(rest);
                    Map<String, dynamic> val =
                        jsonDecode(jsonEncode(res['errors']));
                    val.forEach((key, value) =>
                        message = '$message ${value.join(', ')}');
                  }
                  networkExceptions =
                      NetworkExceptions.formDataInvalid(message);
                  break;
                case 500:
                  networkExceptions = NetworkExceptions.internalServerError();
                  break;
                case 503:
                  networkExceptions = NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  var responseCode = error.response?.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    "Received invalid status code: $responseCode",
                  );
              }
              break;
            case DioErrorType.cancel:
              networkExceptions = NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.other:
              networkExceptions = NetworkExceptions.noInternetConnection();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = NetworkExceptions.noInternetConnection();
        } else {
          log('$stackTrace');
          networkExceptions = NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        log('$stackTrace');
        return NetworkExceptions.formatException();
      } catch (e) {
        log('Error $e');
        log('$stackTrace');
        return NetworkExceptions.unexpectedError();
      }
    } else {
      log(error.toString());
      log('$stackTrace');
      if (error.toString().contains("is not a subtype of")) {
        return NetworkExceptions.unableToProcess();
      } else {
        return NetworkExceptions.defaultError(error.toString());
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(notImplemented: () {
      errorMessage = "Not Implemented";
    }, requestCancelled: () {
      errorMessage = "Request Cancelled";
    }, internalServerError: () {
      errorMessage = "Internal Server Error";
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = "Service unavailable";
    }, methodNotAllowed: () {
      errorMessage = "Method Allowed";
    }, badRequest: () {
      errorMessage = "Bad request";
    }, unauthorisedRequest: () {
      errorMessage = "Unauthorised request";
      // AuthController.find.signOut();
    }, unexpectedError: () {
      errorMessage = "Unexpected error occurred";
    }, requestTimeout: () {
      errorMessage = "Connection request timeout";
    }, noInternetConnection: () {
      errorMessage = "No internet connection";
    }, conflict: () {
      errorMessage = "Error due to a conflict";
    }, sendTimeout: () {
      errorMessage = "Send timeout in connection with API server";
    }, unableToProcess: () {
      errorMessage = "Unable to process the data";
    }, defaultError: (String error) {
      errorMessage = '$error';
    }, formatException: () {
      errorMessage = "Unexpected error occurred";
    }, notAcceptable: () {
      errorMessage = "Not acceptable";
    }, formDataInvalid: (String errors) {
      errorMessage = '$errors';
    });
    return errorMessage;
  }
}

extension FutureAPIResultExt<T extends BaseResponse> on Future<T> {
  Future<T> validateStatus() {
    return then((value) async {
      final code = value.status;
      final message = value.message;
      // You can use this if has multiple domain url and separate the error
      // final domain = value.domain;
      // log("DOMAIN => $domain");
      if (code >= 200 && code <= 299) return value;
      // if (code == 401) AuthController.find.signOut();
      throw message;
    });
  }

  Future<T> validateData() {
    return then((value) {
      const error = 'Terjadi kesalahan dalam koneksi';
      if (value is ResponseObject) {
        if (value.data != null) {
          return value;
        } else {
          throw value.message.isNotEmpty ? value.message : error;
        }
      }
      if (value is ResponseList) {
        if (value.data != null) {
          return value;
        } else {
          throw value.message.isNotEmpty ? value.message : error;
        }
      }
      return value;
    });
  }

  Future<T> validateResponse() => validateStatus().validateData();
}

extension FutureExt<T> on Future<T> {
  Future<T> summarizeError() {
    return catchError((error, stackTrace) async {
      throw ErrorHandler.getErrorMessage(
          ErrorHandler.getDioException(error, stackTrace));
    });
  }

  Future<T> handleError(Function onError) async =>
      summarizeError().catchError(onError);
}
