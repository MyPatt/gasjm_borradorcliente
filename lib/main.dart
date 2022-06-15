import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/dependency_injection.dart';
import 'package:gasjm/app/modules/splash/splash_binding.dart';
import 'package:gasjm/app/modules/splash/splash_page.dart';
import 'package:gasjm/app/modules/ubicacion/blocs/gps/gps_bloc.dart';
import 'package:gasjm/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  DependencyInjection.init();
  // runApp(MyApp());
  //Para obtener estado del GPS
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GpsBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gas J&M',
      theme: ThemeData(
        /*  primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        */
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
    );
  }
}
