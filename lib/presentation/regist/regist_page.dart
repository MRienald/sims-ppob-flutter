// ignore_for_file: prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:nutech_flutter_apps/presentation/regist/regist_controller.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/routes/page_names.dart';
import 'package:nutech_flutter_apps/utils/helper/validator.dart';
import 'package:nutech_flutter_apps/utils/widget/sims_ppob_logo.dart';
import 'package:sizer/sizer.dart';

class RegistPage extends StatelessWidget {
  const RegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistController>(
      init: RegistController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: FormBuilder(
              key: controller.formKey,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SimsPpobLogo(),
                    SizedBox(height: 5.h,),
                    Text(
                      "Lengkapi data untuk membuat akun",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: (6.5).w,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    FormBuilderTextField(
                      name: 'username',
                      //enabled: !controller.isLoading,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        icon: Text(
                          "@",
                          style: TextStyle(
                            fontSize: 5.w
                          ),
                        ),
                        fillColor: Colors.transparent,
                        hintText: 'Masukkan Email anda',
                      ),
                      validator: Validator.required(),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 3.h,),
                    FormBuilderTextField(
                      name: 'firstname',
                      //enabled: !controller.isLoading,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        fillColor: Colors.transparent,
                        hintText: 'nama depan',
                      ),
                      validator: Validator.required(),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 3.h,),
                    FormBuilderTextField(
                      name: 'lastname',
                      //enabled: !controller.isLoading,
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        fillColor: Colors.transparent,
                        hintText: 'nama belakang',
                      ),
                      validator: Validator.required(),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 3.h,),
                    FormBuilderTextField(
                      name: 'password',
                      //enabled: !controller.isLoading,
                      obscureText: controller.hidePasswod[0],
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.hideOrShowPassword(0);
                          },
                          child: (controller.hidePasswod[0] == false)
                          ? Icon(Icons.visibility_outlined)
                          : Icon(Icons.visibility_off_outlined),
                        ),
                        icon: Icon(Icons.lock_outline_rounded),
                        fillColor: Colors.transparent,
                        hintText: 'buat password',
                      ),
                      validator: FormBuilderValidators.compose([
                        Validator.required(),
                        (val) {
                          if (val != controller.formKey.currentState?.value['re-password']) {
                            return 'Password tidak cocok';
                          } else {
                            return null;
                          }
                        },
                      ]),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 3.h,),
                    FormBuilderTextField(
                      name: 're-password',
                      //enabled: !controller.isLoading,
                      obscureText: controller.hidePasswod[1],
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.hideOrShowPassword(1);
                          },
                          child: (controller.hidePasswod[1] == false)
                          ? Icon(Icons.visibility_outlined)
                          : Icon(Icons.visibility_off_outlined),
                        ),
                        icon: Icon(Icons.lock_outline_rounded),
                        fillColor: Colors.transparent,
                        hintText: 'konfirmasi password',
                      ),
                      validator: FormBuilderValidators.compose([
                        Validator.required(),
                        (val) {
                          if (val != controller.formKey.currentState?.value['password']) {
                            return 'Password tidak cocok';
                          } else {
                            return null;
                          }
                        },
                      ]),
                      keyboardType: TextInputType.text,
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.formKey.currentState !=
                            null &&
                        controller.formKey.currentState!
                            .saveAndValidate()){
                          controller.registAccount();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 8.h),
                        alignment: Alignment.center,
                        height: 5.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.red
                        ),
                        child: Text(
                          'Registrasi',
                          style: TextStyle(
                            fontSize: 4.w,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "sudah punya akun? login",
                            style: TextStyle(
                              fontSize: (3.5).w,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.offAndToNamed(PageName.LOGIN);
                            },
                            child: Text(
                              " di sini",
                              style: TextStyle(
                                fontSize: (3.5).w,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryRed
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}