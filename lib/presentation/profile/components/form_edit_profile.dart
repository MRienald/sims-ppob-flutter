import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/utils/helper/validator.dart';
import 'package:sizer/sizer.dart';

class FormEditProfile extends StatelessWidget {
  const FormEditProfile({super.key, this.controller});

  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: TextStyle(
              fontSize: 4.w,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral70
            ),
          ),
          SizedBox(height: 1.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.neutral30
              ),
              borderRadius: BorderRadius.circular(5)
            ),
            child: FormBuilderTextField(
              name: 'email',
              initialValue: controller.authController.user?.email,
              style: Theme.of(context).textTheme.headline5,
              decoration: InputDecoration(
                icon: Text(
                  "@",
                  style: TextStyle(
                    fontSize: 6.w,
                    fontWeight: FontWeight.w700
                  ),
                ),
                fillColor: Colors.transparent,
                hintText: 'masukkan email',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              validator: Validator.required(),
              keyboardType: TextInputType.text,
            ),
          ),
          SizedBox(height: 2.h,),
          Text(
            "Nama Depan",
            style: TextStyle(
              fontSize: 4.w,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral70
            ),
          ),
          SizedBox(height: 1.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.neutral30
              ),
              borderRadius: BorderRadius.circular(5)
            ),
            child: FormBuilderTextField(
              name: 'first_name',
              initialValue: controller.authController.user?.firstName,
              style: Theme.of(context).textTheme.headline5,
              decoration: InputDecoration(
                icon: Icon(Icons.person_outline_rounded),
                fillColor: Colors.transparent,
                hintText: 'masukkan nama depan',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              validator: Validator.required(),
              keyboardType: TextInputType.text,
            ),
          ),
          SizedBox(height: 2.h,),
          Text(
            "Nama Belakang",
            style: TextStyle(
              fontSize: 4.w,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral70
            ),
          ),
          SizedBox(height: 1.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.neutral30
              ),
              borderRadius: BorderRadius.circular(5)
            ),
            child: FormBuilderTextField(
              name: 'last_name',
              initialValue: controller.authController.user?.lastName,
              style: Theme.of(context).textTheme.headline5,
              decoration: InputDecoration(
                icon: Icon(Icons.person_outline_rounded),
                fillColor: Colors.transparent,
                hintText: 'masukkan nama belakang',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              validator: Validator.required(),
              keyboardType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}