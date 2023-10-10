import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nutech_flutter_apps/presentation/topup/component/form_nominal.dart';
import 'package:nutech_flutter_apps/presentation/topup/component/nominal_item.dart';
import 'package:nutech_flutter_apps/presentation/topup/topup_controller.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:nutech_flutter_apps/utils/widget/card_saldo.dart';
import 'package:sizer/sizer.dart';

import '../../utils/helper/validator.dart';

class TopUpPage extends StatelessWidget {
  const TopUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopUpController>(
      init: TopUpController(),
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
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
              child: FormBuilder(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardSaldo(
                      showSaldobutton: false,
                      widthCard: double.infinity,
                      controller: controller,
                    ),
                    SizedBox(height: 5.h,),
                    Text(
                      "Silahkan masukkan",
                      style: TextStyle(
                        fontSize: 5.w,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "nominal Top Up",
                      style: TextStyle(
                        fontSize: 7.w,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 7.h,),
                    FormNominal(valueKey: 'top_up_amount',),
                    SizedBox(height: 3.h,),
                    NominalItem(controller: controller,),
                    SizedBox(height: 5.h,),
                    InkWell(
                      onTap: () {
                        controller.modalValidation(context);
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
                          'Top Up',
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
      },
    );
  }
}
