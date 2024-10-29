import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'config/app_colors.dart';
import 'services/getstorage_services.dart';
import 'src/select_bluetooth_screen/controller/select_bluetooth_controller.dart';
import 'src/splash_screen/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBdXA0gwtlDaIA2t1Kv9J-snvezqU8hMMA',
          appId: '1:472630311691:android:71b6147330b8617d93c00e',
          messagingSenderId: '472630311691',
          projectId: 'psykitz-891d8'));

  await Get.putAsync<SelectBluetoothController>(() async => SelectBluetoothController(), permanent: true);
  await Get.putAsync<StorageServices>(() async => StorageServices());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      log("detached");
    } else if (state == AppLifecycleState.paused) {
      log("paused");
    } else if (state == AppLifecycleState.resumed) {
      log("resumed");
    } else if (state == AppLifecycleState.inactive) {
      log("inactive");
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Psykitz',
        theme: ThemeData(
          // fontFamily: "BariolNormal",
          primarySwatch: MaterialColor(0xff64EBB6, AppColors.mainMaterialColor),
        ),
        home: const SplashPage(),
      );
    });
  }
}
