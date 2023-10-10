import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:sizer/sizer.dart';

class NominalItem extends StatelessWidget {
  const NominalItem({
    Key? key, this.controller,
  }) : super(key: key);

  final controller;

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 30,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
      ),
      itemCount: controller.nominalItems.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            controller.chooseNominalItems(
              controller.nominalItems.keys.elementAt(index)
            );
          },
          child: Container(
            height: 12.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: controller.nominalItems.values.elementAt(index) == true 
              ? AppColors.neutral30
              : AppColors.white,
              border: Border.all(
                width: 1,
                color: AppColors.neutral40
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              "${controller.nominalItems.keys.elementAt(index)}"
            ),
          ),
        );
      },
    );
  }
}