import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutech_flutter_apps/presentation/transaction/transaction_controller.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/utils/widget/card_saldo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
      init: TransactionController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'Top Up',
                style: TextStyle(
                  fontSize: 5.w,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
          body: SmartRefresher(
            enablePullDown: true,
            // enablePullUp: controller.hasNext.value,
            controller: controller.refreshController,
            onRefresh: controller.refreshPage,
            onLoading: controller.loadNextPage,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardSaldo(
                      showSaldobutton: false,
                      widthCard: double.infinity,
                      controller: controller,
                    ),
                    SizedBox(height: 3.h,),
                    Text(
                      "Transaksi",
                      style: TextStyle(
                        fontSize: 5.w,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(height: 3.h,),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.dataList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 3.h
                            ),
                            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.neutral30
                              ),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (controller.dataList[index].transactionType == "TOPUP")
                                      ? "+ Rp.${controller.formatNumber(controller.dataList[index].totalAmount.toString())}"
                                      : "- Rp.${controller.formatNumber(controller.dataList[index].totalAmount.toString())}",
                                      style: TextStyle(
                                        color: (controller.dataList[index].transactionType == "TOPUP")
                                        ? AppColors.appBar
                                        : AppColors.primaryRed,
                                        fontSize: 5.w,
                                        fontWeight: FontWeight.w800
                                      ),
                                    ),
                                    SizedBox(height: 1.h,),
                                    Text(
                                      "${controller.formattedDate[index]}  |  ${controller.formattedDateTime[index]}",
                                      // "${controller.formatDate(controller.dataList[index].createdOn ?? DateTime.now())}",
                                      style: TextStyle(
                                        color: AppColors.neutral40,
                                        fontSize: 2.w,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Keterangan",
                                  style: TextStyle(
                                    color: AppColors.neutral60,
                                    fontSize: 3.w,
                                    fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 1.h,),
                    Center(
                      child: InkWell(
                        onTap: () {
                          controller.showMoreTransaction();
                        },
                        child: Container(
                          height: 4.h,
                          width: 30.w,
                          alignment: Alignment.center,
                          child: Text(
                            controller.listviewLenght + 1 > controller.dataList.length ? "Show more" : "-- Hide --",
                            style: TextStyle(
                              fontSize: (3.5).w,
                              fontWeight: FontWeight.w700,
                              color: AppColors.red
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}