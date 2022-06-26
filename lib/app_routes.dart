import 'package:get/route_manager.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/add/add.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/add/add_binding.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/auth/auth_binding.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/auth/login.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/auth/register.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/cart/cart_binding.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/cart/cart_page.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/detail/detail_binding.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/detail/detail_page.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/home/homepage_binding.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/master_binding.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/splash/splash.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/masterpage.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/stats/stats_binding.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/transaction/detail_transaction_binding.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/transaction/detail_transaction_page.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/update/update.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/update/update_binding.dart';

import 'pages/stats/stats.dart';

class AppRoutes {
  static String masterRoute = '/';
  static String registerRoute = '/register';
  static String loginRoute = '/login';
  static String splashRoute = '/splash';
  static String homepageRoute = '/homepage';
  static String statsRoute = '/stats';
  static String detailRoute = '/detail';
  static String addRoute = '/add';
  static String updateRoute = '/update';
  static String cartRoute = '/cart';
  static String detailTransactionRoute = '/detail_transaction';

  List<GetPage> listOfPage = [
    GetPage(
      name: masterRoute,
      page: () => MasterPage(),
      bindings: [
        HomepageBinding(),
        MasterBinding(),
        StatsBinding(),
      ],
    ),
    GetPage(
      name: homepageRoute,
      page: () => HomePage(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: statsRoute,
      page: () => StatsPage(),
      binding: StatsBinding(),
    ),
    GetPage(
      name: registerRoute,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: loginRoute,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: splashRoute,
      page: () => SplashScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: detailRoute,
      page: () => DetailPage(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: addRoute,
      page: () => AddPage(),
      binding: AddBinding(),
    ),
    GetPage(
      name: updateRoute,
      page: () => UpdatePage(),
      binding: UpdateBinding(),
    ),
    GetPage(
      name: cartRoute,
      page: () => CartPage(),
      bindings: [CartBinding(), StatsBinding()],
    ),
    GetPage(
      name: detailTransactionRoute,
      page: () => DetailTransactionPage(),
      binding: DetailTransactionBinding(),
    ),
  ];
}
