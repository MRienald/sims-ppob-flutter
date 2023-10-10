import 'package:flutter/material.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:sizer/sizer.dart';

class SimsPpobLogo extends StatelessWidget {
  final double? height_logo;
  final double? width_logo;
  final double? font_size;
  const SimsPpobLogo({super.key, this.height_logo, this.width_logo, this.font_size});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.imgLogo.path,
          height: height_logo ?? 5.h,
          width: width_logo ?? 8.w,
        ),
        SizedBox(width: 2.w,),
        Text(
          "SIMS PPOB",
          style: TextStyle(
            fontSize: font_size ?? 5.w,
            fontWeight: FontWeight.w700
          ),
        )
      ],
    );
  }
}