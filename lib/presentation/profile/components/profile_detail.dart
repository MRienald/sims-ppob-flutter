import 'package:flutter/material.dart';
import 'package:nutech_flutter_apps/presentation/profile/components/form_profile.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:sizer/sizer.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    Key? key,
    this.controller
  }) : super(key: key);

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
          FormProfile(
            icon: Text(
              "@",
              style: TextStyle(
                fontSize: 6.w,
                fontWeight: FontWeight.w700
              ),
            ),
            content: controller.authController.user?.email ?? "daftarkan email!!!",
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
          FormProfile(
            icon: Icon(Icons.person_outline_rounded),
            content: controller.authController.user?.firstName ?? "Nama Depan",
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
          FormProfile(
            icon:Icon(Icons.person_outline_rounded),
            content: controller.authController.user?.lastName ?? "nama belakang",
          ),
        ],
      ),
    );
  }
}