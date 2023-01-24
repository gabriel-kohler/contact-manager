import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:project_test/utils/utils.dart';

import '../infrastructure/infrastructure.dart';
import 'injections/injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  GeocodingPlatform get geocoding => GeocodingPlatform.instance;

  LocalStorage get localStorage => LocalStorage('projecttest');

  @override
  Widget build(BuildContext context) {
    final editContactUiController =
        makeEditContactUiController(localStorage, geocoding);
    final routeObserver = Get.put<RouteObserver>(RouteObserver<PageRoute>());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: makeSplashPage(localStorage),
      navigatorObservers: [routeObserver],
      getPages: [
        GetPage(
          name: AppRoutes.splashPage,
          page: () => makeSplashPage(localStorage),
        ),
        GetPage(
          name: AppRoutes.signIn,
          page: () => makeLoginPage(firebaseAuth, localStorage),
        ),
        GetPage(
          name: AppRoutes.signUp,
          page: () => makeSignUpPage(firebaseAuth, localStorage),
        ),
        GetPage(
          name: AppRoutes.addContactPage,
          page: () => makeAddContactPage(localStorage, geocoding),
        ),
        GetPage(
          name: AppRoutes.homePage,
          page: () => makeHomePage(
            LocalStorageAdapter(
              localStorage: localStorage,
            ),
            firebaseAuth,
          ),
        ),
        GetPage(
          name: AppRoutes.contactDetailPage,
          page: () => makeContactDetailPage(editContactUiController),
        ),
        GetPage(
          name: AppRoutes.contactAddressDetailPage,
          page: () => makeContactAddressDetailPage(editContactUiController),
        ),
      ],
    );
  }
}


