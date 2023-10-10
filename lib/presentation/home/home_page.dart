import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutech_flutter_apps/presentation/home/component/content_home.dart';
import 'package:nutech_flutter_apps/presentation/home/component/header.dart';
import 'package:nutech_flutter_apps/presentation/home/home_controller.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/utils/widget/sims_ppob_logo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: SmartRefresher(
              enablePullDown: true,
              // enablePullUp: controller.hasNext.value,
              controller: controller.refreshController,
              onRefresh: controller.refreshPage,
              onLoading: controller.loadNextPage,
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Column(
                    children: [
                      header(controller: controller,),
                      ContentHome(controller: controller,),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 2.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: Text(
                                "Temukan Promo Menarik",
                                style: TextStyle(
                                  fontSize: 5.w,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h,),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 20.h,
                                viewportFraction: 0.8,
                                autoPlay: true,
                              ),
                              items: controller.carouselListItems.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Image.network(
                                        i.bannerImage ?? "",
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}