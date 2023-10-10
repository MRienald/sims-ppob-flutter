import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nutech_flutter_apps/presentation/profile/components/avatar_profile.dart';
import 'package:nutech_flutter_apps/presentation/profile/components/profile_detail.dart';
import 'package:nutech_flutter_apps/presentation/profile/profile_controller.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/routes/page_names.dart';
import 'package:nutech_flutter_apps/utils/dialog/modal_dialog.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'Akun',
                style: TextStyle(
                  fontSize: 5.w,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Column(
                children: [
                  AvatarProfile(controller: controller),
                  SizedBox(height: 3.h,),
                  ProfileDetail(controller: controller),
                  SizedBox(height: 5.h,),
                  InkWell(
                    onTap: () {
                      Get.toNamed(PageName.EDITPROFILE);
                    },
                    child: Container(
                      height: 5.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryRed,
                        borderRadius: BorderRadius.circular(3)
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 4.w,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  InkWell(
                    onTap: () {
                      ModalDialog.YYDialogAttention(
                        context, 
                        opacity: 1,
                        content_top: "Apakah anda yakin ingin keluar dari aplikasi?",
                        content_button: "Lanjutkan",
                        buttonNext: (){
                          controller.authController.signOut();
                        }, 
                        buttonClose: (){
                          Get.back();
                        }
                      );
                    },
                    child: Container(
                      height: 5.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.primaryRed
                        ),
                        borderRadius: BorderRadius.circular(3)
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 4.w,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryRed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}