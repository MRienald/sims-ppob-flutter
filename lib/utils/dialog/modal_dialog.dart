// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:nutech_flutter_apps/resources/fonts.gen.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:sizer/sizer.dart';

mixin ModalDialog {
  
  static YYDialog YYDialogPickImage(
    BuildContext context,
    controller,
  ) {
    return YYDialog().build(context)
      ..width = 70.w
      ..height = 32.h
      ..backgroundColor = AppColors.background1.withOpacity(0.8)
      ..borderRadius = 10.0
      ..showCallBack = () {
        print("showCallBack invoke");
      }
      ..dismissCallBack = () {
        print("dismissCallBack invoke");
      }
      ..widget(Padding(
        padding: EdgeInsets.only(top: 10.w),
        child: Text(
          "Tambah Gambar",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(
          top: 10.w,
          left: 8.w,
          right: 8.w,
        ),
        child: Text(
          "Silahkan tambahkan gambar melalui Gallery atau ambil gambar baru dengan Camera!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize:14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Container(
        margin: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          top: 8.w
        ),
        height: 15.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                controller.pickImageFromGalerry();
                Navigator.pop(context);
              },
              child: Container(
                height: 12.w,
                width: 21.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.appBar
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(
                  Icons.phone_android_rounded
                ),
              ),
            ),
            InkWell(
              onTap: () {
                controller.pickImageFromCamera();
                Navigator.pop(context);
              },
              child: Container(
                height: 12.w,
                width: 21.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.appBar
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(
                  Icons.camera_alt_rounded
                ),
              ),
            ),
          ],
        ),
      ))
      ..animatedFunc = (child, animation) {
        return ScaleTransition(
          child: child,
          scale: Tween(begin: 0.0, end: 1.0).animate(animation),
        );
      }
      ..show();
  }

  static YYDialog YYDialogError(
    BuildContext context,
    {
      String? content_bold,
      String? content_soft,
      String? content_top,
      String? content_bottom,
      String? content_button,
      required Function buttonAction,
    }
  ) {
    return YYDialog().build(context)
      ..width = 85.w
      ..height = 35.h
      ..backgroundColor = AppColors.background1.withOpacity(0.9)
      ..borderRadius = 10.0
      ..showCallBack = () {
        print("showCallBack invoke");
      }
      ..dismissCallBack = () {
        print("dismissCallBack invoke");
      }
      ..widget(Padding(
        padding: EdgeInsets.only(top: 5.w),
        child: Image.asset(
          AppImages.icError.path,
          width: 18.w,
          height: 18.w,
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(
          top: 3.w,
          left: 4.w,
          right: 4.w,
        ),
        child: Text(
          content_top ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 4.w,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(top: (2.5).w),
        child: Text(
          content_bold ?? '',
          style: TextStyle(
            fontSize: 6.w,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(top: 4.w),
        child: Text(
          content_bottom ?? '',
          style: TextStyle(
            fontSize: 4.w,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(
          top: 1.w,
          left: 4.w,
          right: 4.w,
        ),
        child: Text(
          content_soft ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 3.w,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(
          top: 5.w,
          left: 4.w,
          right: 4.w,
        ),
        child: InkWell(
          onTap: () => buttonAction(),
          child: Container(
            height: 10.w,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              content_button ?? 'Kembali',
              style: TextStyle(
                color: AppColors.primaryRed,
                fontFamily: FontFamily.avenir,
                fontWeight: FontWeight.w700,
                fontSize: 4.w
              ),
            ),
          ),
        )
      ))
      ..animatedFunc = (child, animation) {
        return ScaleTransition(
          child: child,
          scale: Tween(begin: 0.0, end: 1.0).animate(animation),
        );
      }
      ..show();
  }

  static YYDialog YYDialogAttention(
    BuildContext context,
    {
      String? content_bold,
      String? content_top,
      String? content_button,
      double? opacity,
      required Function buttonNext,
      required Function buttonClose,
    }
  ) {
    return YYDialog().build(context)
      ..width = 85.w
      ..height = 41.h
      ..backgroundColor = AppColors.background1.withOpacity(opacity ?? 0.9)
      ..borderRadius = 10.0
      ..barrierDismissible = false
      ..showCallBack = () {
        print("showCallBack invoke");
      }
      ..dismissCallBack = () {
        print("dismissCallBack invoke");
      }
      ..widget(Padding(
        padding: EdgeInsets.only(top: 10.w),
        child: Image.asset(
          AppImages.imgLogo.path,
          width: 18.w,
          height: 18.w,
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(
          top: 10.w,
          left: 4.w,
          right: 4.w,
        ),
        child: Text(
          content_top ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 4.w,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(top: (2.5).w),
        child: Text(
          content_bold ?? '',
          style: TextStyle(
            fontSize: 6.w,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(
          top: 5.w,
          left: 4.w,
          right: 4.w,
        ),
        child: InkWell(
          onTap: () => buttonNext(),
          child: Container(
            color: AppColors.neutral20.withOpacity(0.1),
            height: 10.w,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              content_button ?? 'Kembali',
              style: TextStyle(
                color: AppColors.primaryRed,
                fontFamily: FontFamily.avenir,
                fontWeight: FontWeight.w700,
                fontSize: 4.5.w
              ),
            ),
          ),
        )
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(
          top: 2.w,
          left: 4.w,
          right: 4.w,
        ),
        child: InkWell(
          onTap: () => buttonClose(),
          child: Container(
            color: AppColors.neutral20.withOpacity(0.1),
            height: 10.w,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'Batalkan',
              style: TextStyle(
                color: AppColors.neutral40,
                fontFamily: FontFamily.avenir,
                fontWeight: FontWeight.w700,
                fontSize: 4.w
              ),
            ),
          ),
        )
      ))
      ..animatedFunc = (child, animation) {
        return ScaleTransition(
          child: child,
          scale: Tween(begin: 0.0, end: 1.0).animate(animation),
        );
      }
      ..show();
  }

  static YYDialog YYDialogSuccess(
    BuildContext context,
    {
      String? content_bold,
      String? content_soft,
      String? content_top,
      String? content_bottom,
      String? content_button,
      required Function buttonAction,
    }
  ) {
    return YYDialog().build(context)
      ..width = 85.w
      ..height = 35.h
      ..backgroundColor = AppColors.background1.withOpacity(0.9)
      ..borderRadius = 10.0
      ..barrierDismissible = false
      ..showCallBack = () {
        print("showCallBack invoke");
      }
      ..dismissCallBack = () {
        print("dismissCallBack invoke");
      }
      ..widget(Padding(
        padding: EdgeInsets.only(top: 5.w),
        child: Image.asset(
          AppImages.icSuccess.path,
          width: 18.w,
          height: 18.w,
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(
          top: 3.w,
          left: 4.w,
          right: 4.w,
        ),
        child: Text(
          content_top ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 4.w,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(top: (2.5).w),
        child: Text(
          content_bold ?? '',
          style: TextStyle(
            fontSize: 6.w,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(top: 4.w),
        child: Text(
          content_bottom ?? '',
          style: TextStyle(
            fontSize: 4.w,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(
          top: 1.w,
          left: 4.w,
          right: 4.w,
        ),
        child: Text(
          content_soft ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 3.w,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ))
      ..widget(Padding(
        padding: EdgeInsets.only(
          top: (content_soft == null) ? 3.w : 5.w,
          left: 4.w,
          right: 4.w,
        ),
        child: InkWell(
          onTap: () => buttonAction(),
          child: Container(
            height: 10.w,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              content_button ?? 'Kembali',
              style: TextStyle(
                color: AppColors.primaryRed,
                fontFamily: FontFamily.avenir,
                fontWeight: FontWeight.w700,
                fontSize: 4.w
              ),
            ),
          ),
        )
      ))
      ..animatedFunc = (child, animation) {
        return ScaleTransition(
          child: child,
          scale: Tween(begin: 0.0, end: 1.0).animate(animation),
        );
      }
      ..show();
  }

}