import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class Validator {
  
  static FormFieldValidator<T> list<T>(List<FormFieldValidator<T>> validators) {
    return (valueCandidate) {
      for (var validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };
  }

  static FormFieldValidator<T> required<T>() {
    return FormBuilderValidators.required(errorText: 'Data tidak boleh kosong!');
  }

  FormFieldValidator<T> nominalBalance<T>() {
    return (v) {
      int nominal = convertToInteger(v.toString());
      if(nominal < 10000){
        return 'minimal top up Rp10.000';
      } else if (nominal > 1000000) {
        return 'maksimal top up Rp1.000.000';
      } else {
        return null;
      }
    };
  }

  FormFieldValidator<T> paymentValidate<T>(String saldo) {
    return (v) {
      int nominal = convertToInteger(v.toString());
      int balance = convertToInteger(saldo.toString());
      if(nominal > balance){
        return 'Saldo anda tidak cukup!';
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> email<T>(String err) {
    return FormBuilderValidators.email(errorText: err);
  }

  static FormFieldValidator<String> emailPhone<T>(String err) {
    return (v) {
      if (v != null) {
        if (GetUtils.isEmail(v) || GetUtils.isPhoneNumber(v)) {
          return null;
        } else {
          return err;
        }
      } else {
        return err;
      }
    };
  }

  static FormFieldValidator minLength(int minLength, String err) {
    return FormBuilderValidators.minLength(
      minLength,
      errorText: err,
      allowEmpty: false,
    );
  }

  static FormFieldValidator equal(String comparator, String err) {
    return FormBuilderValidators.equal(comparator, errorText: err);
  }

  String? password(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'txt_valid_password'.tr;
    else
      return null;
  }

  String? name(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'txt_valid_name'.tr;
    else
      return null;
  }

  String? number(String? value) {
    String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'txt_valid_number'.tr;
    else
      return null;
  }

  String? notEmpty(String? value) {
    String pattern = r'^\S+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'txt_valid_notEmpty'.tr;
    else
      return null;
  }

  int convertToInteger(String input) {
    String cleanedString = input.replaceAll('Rp', '').replaceAll('.', '').replaceAll(' ', '');
    int? result = int.tryParse(cleanedString);

    return result ?? 0;
  }

}
