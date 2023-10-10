import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nutech_flutter_apps/presentation/topup/component/form_nominal.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/utils/helper/validator.dart';
import 'package:nutech_flutter_apps/utils/widget/card_saldo.dart';
import 'package:sizer/sizer.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key, this.controller, this.index});

  final controller;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(left: 25.w),
          child: Text(
            'PemBayaran',
            style: TextStyle(
              fontSize: 5.w,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: FormBuilder(
          key: controller.formKey,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardSaldo(
                  showSaldobutton: false,
                  widthCard: double.infinity,
                  controller: controller,
                ),
                SizedBox(height: 10.h,),
                Text(
                  "PemBayaran",
                  style: TextStyle(
                    fontSize: 4.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.neutral60
                  ),
                ),
                SizedBox(height: 2.h,),
                Container(
                  margin: EdgeInsets.only(left: 2.w),
                  child: Row(
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
                      SizedBox(width: 5.w,),
                      Text(
                        controller.dataList[index].serviceName,
                        style: TextStyle(
                          fontSize: 5.w,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5.h,),
                FormNominal(
                  valueKey: 'service_code',
                  initial : "Rp ${controller.formatNumber(controller.dataList[index].serviceTariff.toString())}",
                  readOnly: true,
                  validator: Validator().paymentValidate(
                    controller.authController.balance
                  ),
                ),
                SizedBox(height: 10.h,),
                InkWell(
                  onTap: () {
                    controller.modalValidation(context, index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: (2.5).h),
                    alignment: Alignment.center,
                    height: 5.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      'Bayar',
                      style: TextStyle(
                        fontSize: 4.w,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white
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
  }
}