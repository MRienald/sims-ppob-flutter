import 'package:flutter/material.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:sizer/sizer.dart';

class CardSaldo extends StatelessWidget {
  const CardSaldo({
    Key? key,
    required this.showSaldobutton, this.widthCard, this.controller,
  }) : super(key: key);

  final controller;
  final bool? showSaldobutton;
  final double? widthCard;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImages.backgroundSaldo.path,
          width: widthCard,
        ),
        Container(
          width: double.infinity,
          height: 20.h,
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Saldo Anda",
                style: TextStyle(
                  fontSize: 4.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white
                ),
              ),
              SizedBox(height: 1.h,),
              Text(
                (controller.shownominal || showSaldobutton == false) ? "Rp ${controller.authController.balance}" : "Rp •••••••" ,
                style: TextStyle(
                  fontSize: 8.w,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white
                ),
              ),
              SizedBox(height: 3.h,),
              (showSaldobutton ?? false)
              ? InkWell(
                  onTap: () {
                    controller.changeViewSaldo();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Lihat Saldo',
                        style: TextStyle(
                          fontSize: 3.w,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white
                        ),
                      ),
                      SizedBox(width: 2.w,),
                      (controller.shownominal)
                      ? Icon(
                          Icons.visibility_outlined,
                          size: (3.5).w,
                          color: AppColors.white,
                        )
                      : Icon(
                          Icons.visibility_off_outlined,
                          size: (3.5).w,
                          color: AppColors.white,
                        )
                    ],
                  ),
                )
              : SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}