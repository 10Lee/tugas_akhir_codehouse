import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      getPages: AppRoutes().listOfPage,
      initialRoute: AppRoutes.splashRoute,
      // initialBinding: GlobalBinding(),
    );
  }
}
