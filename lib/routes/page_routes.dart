import 'package:get/get.dart';
import 'package:nutech_flutter_apps/presentation/home/home_page.dart';
import 'package:nutech_flutter_apps/presentation/login/login_page.dart';
import 'package:nutech_flutter_apps/presentation/navbar/navBar.dart';
import 'package:nutech_flutter_apps/presentation/edit_profile/edit_profile_page.dart';
import 'package:nutech_flutter_apps/presentation/pembayaran/pembayaran_page.dart';
import 'package:nutech_flutter_apps/presentation/regist/regist_page.dart';
import 'package:nutech_flutter_apps/presentation/splashscreen/splashscreen_page.dart';
import 'package:nutech_flutter_apps/routes/page_names.dart';
import 'package:nutech_flutter_apps/utils/widget/loading_page.dart';

class PageRoutes{
  static final pages = [
    GetPage(
      name: PageName.LOADER,
      page: () => const LoadingPage(),
    ),
    GetPage(
      name: PageName.LOGIN,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: PageName.REGIST,
      page: () => const RegistPage(),
    ),
    GetPage(
      name: PageName.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: PageName.NAVBAR,
      page: () => const NavBar(),
    ),
    GetPage(
      name: PageName.EDITPROFILE,
      page: () => const EditProfilePage(),
    ),
    GetPage(
      name: PageName.PEMBAYARAN,
      page: () => const PembayaranPage(),
    ),
    GetPage(
      name: PageName.SPLASHSCREEN,
      page: () => const SplashScreenPage(),
    ),
  ];
}