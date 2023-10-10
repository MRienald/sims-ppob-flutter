import 'package:flutter/material.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/utils/dialog/modal_dialog.dart';
import 'package:sizer/sizer.dart';

class AvatarProfile extends StatelessWidget {
  const AvatarProfile({
    Key? key,
    this.controller
  }) : super(key: key);

  final controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 35.w,
              height: 35.w,
            ),
            Positioned(
              top: 10,
              right: 10,
              bottom: 10,
              left: 10,
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                backgroundImage:
                ((controller.authController.user?.profileImage ?? "" ).split('/').last != 'null')
                ? Image.network(
                    controller.authController.user?.profileImage,
                  ).image
                : Image.asset(AppImages.imgProfile1.path).image,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.neutral40,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.neutral40,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.edit,
                  size: 5.w,
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: InkWell(
                onTap: () {
                  ModalDialog.YYDialogPickImage(
                    context,
                    controller,
                  );
                },
                child: Container(
                  height: 12.w,
                  width: 12.w,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
          child: Text(
            (controller.authController.user?.firstName != null)
            ? "${controller.authController.user?.firstName} ${controller.authController.user?.lastName}"
            : "Username",
            maxLines: 1,
            style: TextStyle(
              fontSize: 5.w,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis
            ),
          ),
        )
      ],
    );
  }
}