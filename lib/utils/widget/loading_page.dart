import 'package:flutter/material.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryLight,
        ),
      ),
    );
  }
}
