import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:nutech_flutter_apps/presentation/pembayaran/pembayaran_page.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:sizer/sizer.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    Key? key,
    this.controller
  }) : super(key: key);

  final controller;

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      crossAxisCount: 6,
      mainAxisSpacing: 30,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
      ),
      itemCount: controller.dataList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Get.to(PembayaranPage(
            index: index,
            controller: controller,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 10.w,
                width: 10.w,
                decoration: BoxDecoration(boxShadow: AppShadow.shadow3),
                child: Image.network(
                  controller.dataList[index].serviceIcon,
                  scale: 0.7,
                ),
              ),
              SizedBox(height: 3.w),
              Text(
                controller.dataList[index].serviceName ?? "Menu",
                style: TextStyle(
                  color: AppColors.neutral40,
                  fontSize: 2.w,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}