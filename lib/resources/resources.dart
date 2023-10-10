import 'package:flutter/material.dart';
import 'package:nutech_flutter_apps/resources/assets.gen.dart' as asset;

final AppImages = asset.Assets.lib.resources.images;

class AppColors {
  static const colorPrimary =Color(0xff5dc196);
  static const colorSecondary = const Color(0xff5f96ff);

  static const colorBorder =Color(0xff67a2ff);
  static const blue = Color(0xff65aef0);
  static const green = Color(0xff8cd36c);
  static const yellow = Color(0xffffd450);
  static const red = Color(0xfff52323);

  static const chipBg = Color(0xfff9fcff);
  static const greenUP = Color(0xff14C501);
  static const redDown = Color(0xffFB0A0C);
  static const chipBgborder = Color(0xffd8dde2);

  static const textColor = Color(0xff2f2f4a);

  static const graphColor = Color(0xff71a2ff);
  static const underlineColor = Color(0xffe0e0e4);

  static const colorAccent = Colors.white;
  static const black = Colors.black;
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const borderColor = Colors.black12;
  static const subHintColor = Colors.black45;

  static const errorColor = Colors.redAccent;

  static const blueTag = Color(0xff5f96ff);
  static const greenTag = Color(0xff49c1ba);
  static const orangeTag = Color(0xffffa65f);
  static const redTag = Color(0xfff01e26);
  static const darkGrey = Color(0xff2f2f4a);

  Color subTextColor = const Color(0xff304151).withOpacity(0.6);

  static const appBar = Color(0xFF00BCB4);
  static const primaryLight = Color(0xFFE54F59);
  static const primaryDark = Color(0xFFDE232F);
  static const primaryOrange = Color(0xFFFF9933);
  static const primaryRed = Color(0xFFE54F59);

  // static const buttonAlt = Color(0xFFF5AC07);
  static const buttonAlt = Color(0xFFE54F59);
  static const dangerMain = Color(0xFFDE232F);
  static const dangerBorder = Color(0xFFE8656D);
  static const dangerSurface = Color(0xFFF5BDC1);
  static const warningMain = Color(0xFFF6CE4C);
  static const warningBorder = Color(0xFFF9DD82);
  static const warningSurface = Color(0xFFFBEBB7);
  static const successMain = Color(0xFF169B69);
  static const successBorder = Color(0xFF45AF87);
  static const successSurface = Color(0xFF45AF87);

  // Secondary
  static const secondary1 = Color(0xfffad55e);
  static const secondary2 = Color(0xff16BBB7);
  static const secondary3 = Color(0xff97E3E2);
  static const secondary4 = Color(0xff20B8BE);
  static const secondary5 = Color(0xff1175AD);

  // Neutral
  static const neutral10 =  Color(0xffFFFFFF);
  static const neutral20 =  Color(0xffE6E6E6);
  static const neutral30 =  Color(0xffCCCCCC);
  static const neutral40 =  Color(0xffB3B3B3);
  static const neutral50 =  Color(0xff999999);
  static const neutral60 =  Color(0xff808080);
  static const neutral70 =  Color(0xff181818);
  static const neutral80 =  Color(0xff4D4D4D);
  static const neutral90 =  Color(0xff333333);
  static const neutral100 = Color(0xff191919);

  // Caption
  static const captionColor = Color(0xff6D727F);

  // Background
  static const background1 = Color(0xffFFFFFF);
  static const background2 = Color(0xffF9FAFE);
  static const background3 = Color(0xffFFF1D5);
  static const background4 = Color(0xffDDECE9);

  // Alert
  static const errorState = Color(0xffDB3232);
  static const warningState = Color(0xffFF9800);
  static const successState = Color(0xff00BE82);
  static const info = Color(0xff206CFF);

  // Elemet UI
  static const rejectState =Color(0xffF66951);
  static const postponedState = Color(0xffFFD052);
  static const proposedState = Color(0xff73DEB1);
  static const approvedState = Color(0xff9EDE73);
}


class AppGradient{
  static const LinearGradient appBarGradient = LinearGradient(
    colors: [Color(0xff97E3E2), Color(0xff20B8BE)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppShadow {
  static List<BoxShadow>? shadow3 = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.04),
      blurRadius: 4.0,
      offset: Offset(0, 2),
    )
  ];
}
