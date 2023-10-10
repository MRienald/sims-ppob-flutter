// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nutech_flutter_apps/presentation/home/component/menu_items.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/utils/widget/card_saldo.dart';
import 'package:sizer/sizer.dart';

class ContentHome extends StatelessWidget {
  const ContentHome({
    Key? key, this.controller
  }) : super(key: key);

  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selamat Datang,",
            style: TextStyle(
              fontSize: 6.w,
              fontWeight: FontWeight.w400
            ),
          ),
          Text(
            (controller.authController.user?.firstName != null) 
            ? "${controller.authController.user?.firstName} ${controller.authController.user?.lastName}"
            : "Muhammad Rienaldi Muharam",
            maxLines: 1,
            style: TextStyle(
              fontSize: 7.w,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis
            ),
          ),
          SizedBox(height: 3.h,),
          CardSaldo(showSaldobutton: true, controller : controller),
          SizedBox(height: 2.h,),
          MenuItems(controller : controller),
        ],
      ),
    );
  }
}