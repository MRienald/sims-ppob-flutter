// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:nutech_flutter_apps/model/auth_token.dart';
import 'package:nutech_flutter_apps/model/balance.dart';
import 'package:nutech_flutter_apps/model/carousel.dart';
import 'package:nutech_flutter_apps/model/service_menu.dart';
import 'package:nutech_flutter_apps/model/transaction.dart';
import 'package:nutech_flutter_apps/model/transaction_history.dart';
import 'package:nutech_flutter_apps/model/user.dart';


bool typeEqual<S, T>() => S == T;

bool typeEqualn<S, T>() {
  return typeEqual<S, T>() || typeEqual<S?, T?>();
}

class Converter<T> implements JsonConverter<T, Object> {
  const Converter();

  @override
  T fromJson(Object? json) {
    json = json as Map<String, dynamic>;
    if (typeEqualn<T, User>()) {
      return User.fromJson(json) as T;
    } else if (typeEqualn<T, UserAccount>()) {
      return UserAccount.fromJson(json) as T;
    } else if (typeEqualn<T, AuthToken>()) {
      return AuthToken.fromJson(json) as T;
    } else if (typeEqualn<T, Carousel>()) {
      return Carousel.fromJson(json) as T;
    } else if (typeEqualn<T, ServiceMenu>()) {
      return ServiceMenu.fromJson(json) as T;
    } else if (typeEqualn<T, Balance>()) {
      return Balance.fromJson(json) as T;
    } else if (typeEqualn<T, TransactionHistory>()) {
      return TransactionHistory.fromJson(json) as T;
    } else if (typeEqualn<T, Record>()) {
      return Record.fromJson(json) as T;
    } else if (typeEqualn<T, Transaction>()) {
      return Transaction.fromJson(json) as T;
    } 
    throw UnimplementedError('`$T` fromJson factory unimplemented.');
  }

  @override
  Map<String, dynamic> toJson(T obj) {
    if (typeEqualn<T, User>()) {
      return (obj as User).toJson();
    } else if (typeEqualn<T, UserAccount>()) {
      return (obj as UserAccount).toJson();
    } else if (typeEqualn<T, AuthToken>()) {
      return (obj as AuthToken).toJson();
    } else if (typeEqualn<T, Carousel>()) {
      return (obj as Carousel).toJson();
    } else if (typeEqualn<T, ServiceMenu>()) {
      return (obj as ServiceMenu).toJson();
    } else if (typeEqualn<T, Balance>()) {
      return (obj as Balance).toJson();
    } else if (typeEqualn<T, TransactionHistory>()) {
      return (obj as TransactionHistory).toJson();
    } else if (typeEqualn<T, Record>()) {
      return (obj as Record).toJson();
    } else if (typeEqualn<T, Transaction>()) {
      return (obj as Transaction).toJson();
    } 
    throw UnimplementedError('`$T` toJson factory unimplemented.');
  }
}
