import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/utils/helper/validator.dart';
import 'package:sizer/sizer.dart';

class FormNominal extends StatelessWidget {
  FormNominal({
    Key? key,
    required this.valueKey,
    this.initial,
    this.readOnly,
    this.validator,
  }) : super(key: key);

  String valueKey;
  String? initial;
  bool? readOnly;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.neutral30
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: FormBuilderTextField(
        name: valueKey,
        readOnly: readOnly ?? false,
        initialValue: initial,
        style: Theme.of(context).textTheme.headline5,
        decoration: InputDecoration(
          icon: Icon(Icons.add_card_rounded),
          fillColor: Colors.transparent,
          hintText: 'masukkan nominal Top Up',
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        validator: validator ?? Validator().nominalBalance(),
        keyboardType: TextInputType.number,
      ),
    );
  }
}