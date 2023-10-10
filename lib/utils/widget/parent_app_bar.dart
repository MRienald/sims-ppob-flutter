import 'package:flutter/material.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';

import 'colored_status_bar.dart';

class ParentAppbar extends StatelessWidget {
  const ParentAppbar(
      {Key? key,
      this.color,
      required this.body,
      this.brightness = Brightness.dark,
      this.backImage,
      this.title,
      this.titleStyle,
      this.backgroundColor,
      this.bgScaffold,
      this.actions,
      this.backCallback,
      this.resizeToAvoidBottomInset,
      this.usingDefaultColorStatusBar = false,
      this.bottom})
      : super(key: key);

  final Color? color;
  final Widget body;
  final Brightness brightness;
  final ImageProvider? backImage;
  final String? title;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? bgScaffold;
  final List<Widget>? actions;
  final void Function()? backCallback;
  final bool usingDefaultColorStatusBar;
  final bool? resizeToAvoidBottomInset;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      brightness: brightness,
      color: usingDefaultColorStatusBar ? AppColors.colorPrimary : color,
      child: Scaffold(
        backgroundColor: bgScaffold,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: AppBar(
          title: Text(
            title ?? '',
            style: titleStyle ??
                Theme.of(context).textTheme.headline3?.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.black),
          ),
          centerTitle: false,
          backgroundColor: backgroundColor ?? Colors.transparent,
          elevation: 0.0,
          leading: InkWell(
            onTap: backCallback ?? () => Navigator.of(context).pop(),
            child: Image(
              image: backImage ?? AppImages.btnBack.image().image,
              width: 24,
              height: 24,
            ),
          ),
          actions: actions ?? [],
          bottom: bottom,
        ),
        body: body,
      ),
    );
  }
}
