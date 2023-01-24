import 'package:localstorage/localstorage.dart';
import 'package:project_test/presentation/presenters/splash/splash_ui_controller.dart';

import '../../../core/loadUser/load_user.dart';
import '../../../infrastructure/infrastructure.dart';
import '../../../screens/pages/pages.dart';


SplashPage makeSplashPage(LocalStorage storage) => SplashPage(
  presenter: SplashUiController(
    managerCurrentUser: LocalManagerCurrentUser(
      storage: LocalStorageAdapter(
        localStorage: storage,
      ),
    ),
  ),
);