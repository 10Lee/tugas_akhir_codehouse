import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'config/flutter_config.dart';
import 'global/constants.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.light,
  //   ),
  // );

  FlavorConfig(
    flavor: Flavor.dev,
    baseUrl: kDevBaseUrl,
    appName: kAppName,
  );

  runApp(const MyApp());
}
