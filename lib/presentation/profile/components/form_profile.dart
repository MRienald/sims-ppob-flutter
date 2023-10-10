import 'package:flutter/material.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:sizer/sizer.dart';

class FormProfile extends StatelessWidget {
  FormProfile({
    Key? key, required this.icon, required this.content
  }) : super(key: key);

  Widget icon;
  String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: (2.5).w),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.neutral30
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 4.w,),
          Flexible(
            child: Text(
              content,
              maxLines: 1,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 4.w,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ],
      ),
    );
  }
}