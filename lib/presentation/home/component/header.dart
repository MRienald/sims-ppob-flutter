import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/utils/widget/sims_ppob_logo.dart';
import 'package:sizer/sizer.dart';

class header extends StatelessWidget {
  const header({
    Key? key, this.controller
  }) : super(key: key);

  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimsPpobLogo(
            height_logo: 5.h,
            width_logo: 7.w,
            font_size: 4.w,
          ),
          CircleAvatar(
            backgroundImage:
            ((controller.authController.user?.profileImage ?? "" ).split('/').last != 'null')
            ? Image.network(
                controller.authController.user?.profileImage,
              ).image
            : Image.asset(AppImages.imgProfile2.path).image,
            radius: 5.w,
          ),
        ],
      ),
    );
  }
}