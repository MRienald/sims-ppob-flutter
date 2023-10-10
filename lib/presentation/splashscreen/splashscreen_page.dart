import 'package:flutter/material.dart';
import 'package:nutech_flutter_apps/resources/fonts.gen.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:sizer/sizer.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.imgLogo.path
            ),
            SizedBox(height: 3.h,),
            Text(
              "SIMS PPOB",
              style: TextStyle(
                color: AppColors.neutral70,
                fontFamily: FontFamily.avenir,
                fontSize: 8.w,
                fontWeight: FontWeight.w800
              ),
            ),
            SizedBox(height: 1.h,),
            Text(
              "By. Muhammad Rienaldi Muharam",
              style: TextStyle(
                color: AppColors.neutral60,
                fontFamily: FontFamily.avenir,
                fontSize: 4.w,
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
      ),
    );
  }
}
