

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutech_flutter_apps/main.dart';
import 'package:nutech_flutter_apps/presentation/home/home_page.dart';
import 'package:nutech_flutter_apps/presentation/navbar/navBar_controller.dart';
import 'package:nutech_flutter_apps/presentation/profile/profile_page.dart';
import 'package:nutech_flutter_apps/presentation/topup/topup_page.dart';
import 'package:nutech_flutter_apps/presentation/transaction/transaction_page.dart';
import 'package:nutech_flutter_apps/resources/resources.dart';
import 'package:sizer/sizer.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      init: NavBarController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex.value ?? 0,
              children: [
                HomePage(),
                TopUpPage(),
                TransactionPage(),
                ProfilePage()
              ],
            )
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            elevation: 25,
            iconSize: 28,
            unselectedItemColor: Colors.grey,
            selectedItemColor: AppColors.neutral70,
            currentIndex: controller.tabIndex.value ?? 0,
            onTap: (value) => controller.changeTabMenu(value),
            items: [
              _bottomNavigationBarItem(
                icons: Icons.home_rounded,
                label: "Home"
              ),
              _bottomNavigationBarItem(
                icons: Icons.add_card_rounded,
                label: "Top Up"
              ),
              _bottomNavigationBarItem(
                icons: Icons.credit_card_rounded,
                label: "Transaction"
              ),
              _bottomNavigationBarItem(
                icons: Icons.person,
                label: "Akun"
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({required IconData icons, required String label}){
    return BottomNavigationBarItem(
      activeIcon: Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Icon(
          icons,
          size: 8.w,
        )
      ),
      icon: Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Icon(
          icons,
          size: 7.w,
        )
      ),
      label: label,
    );
  }

}