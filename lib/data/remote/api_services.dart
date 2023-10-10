import 'package:dio/dio.dart';
import 'package:nutech_flutter_apps/data/local/secure/secure_storage_manager.dart';
import 'package:nutech_flutter_apps/data/local/storage/storage_constants.dart';
import 'package:nutech_flutter_apps/data/local/storage/storage_manager.dart';
import 'package:nutech_flutter_apps/data/remote/environment.dart';
import 'package:nutech_flutter_apps/data/remote/interceptor/dio.dart';
import 'package:nutech_flutter_apps/data/remote/wrapper/api_response.dart';
import 'package:nutech_flutter_apps/model/auth_token.dart';
import 'package:nutech_flutter_apps/model/balance.dart';
import 'package:nutech_flutter_apps/model/carousel.dart';
import 'package:nutech_flutter_apps/model/service_menu.dart';
import 'package:nutech_flutter_apps/model/transaction.dart';
import 'package:nutech_flutter_apps/model/transaction_history.dart';
import 'package:nutech_flutter_apps/model/user.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static Future<RestClient> create({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    final _headers = Map<String, dynamic>.from(headers);
    final token = await SecureStorageManager().getToken() ?? "";
    final language =
        await StorageManager().get(StorageName.CURRENT_LOCALE) ?? "id";

    if (!_headers.containsKey("Authorization") && token.isNotEmpty) {
      _headers["Authorization"] = 'Bearer $token';
    }
    _headers["Accept"] = "application/json";
    if (!_headers.containsKey('Content-Type')) {
      _headers["Content-Type"] = 'application/json';
      _headers["Locale"] = language;
    }

    return RestClient(
      await AppDio().getDIO(
        headers: _headers,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
      ),
      baseUrl: ConfigEnvironments.getEnvironments().toString(),
    );
  }

  @POST("/registration")
  Future<ResponseNutech> postRegist(@Body() UserAccount parameter);

  @POST("/login")
  Future<ResponseNutech<AuthToken>> login(@Body() parameter);

  @GET("/profile")
  Future<ResponseNutech<User>> getUser();

  @PUT("/profile/update")
  Future<ResponseNutech<User>> putProfile(@Body() parameter);

  @GET("/banner")
  Future<ResponseListNutech<Carousel>> getCarousel();

  @GET("/services")
  Future<ResponseListNutech<ServiceMenu>> getServiceMenu();

  @GET("/balance")
  Future<ResponseNutech<Balance>> getBalance();

  @POST("/topup")
  Future<ResponseNutech<Balance>> topUpBalance(@Body() parameter);

  @POST("/transaction")
  Future<ResponseNutech<Transaction>> postPayment(@Body() parameter);

  @GET("/transaction/history")
  Future<ResponseNutech<TransactionHistory>> getTransactionHistory(
    @Query("offset") int offset,
    @Query("limit") int limit,
  );
      
}

const client = RestClient.create;