import 'package:get/get.dart';
import 'package:project_test/domain/domain.dart';
import 'package:project_test/screens/pages/pages.dart';
import 'package:project_test/utils/app_routes.dart';

class SplashUiController implements SplashPresenter {
  final ManagerCurrentUser managerCurrentUser;

  SplashUiController({required this.managerCurrentUser});

  @override
  Future<void> checkUser() async {
    try {
      final user = await managerCurrentUser.fetch();
      Get.offNamed(
        AppRoutes.homePage,
        arguments: user,
      );
    } catch (error) {
      print('error > $error');
      Get.offNamed(AppRoutes.signIn);
    }
  }
}
