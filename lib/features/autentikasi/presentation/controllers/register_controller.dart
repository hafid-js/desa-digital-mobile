import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:desa_digital/features/autentikasi/domain/entities/register_step.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final RxBool sembunyikanPassword = true.obs;

  void togglePassword() =>
      sembunyikanPassword.value = !sembunyikanPassword.value;

  bool goto(RegisterStep step) {
    Get.toNamed(_routeOf(step));
    return true;
  }

  void gotoVerifikasiOtp() => Get.toNamed(Routes.verifikasiOtp);

  static String _routeOf(RegisterStep step) => switch (step) {
    RegisterStep.email => Routes.registerStep1,
    RegisterStep.namaLengkap => Routes.registerStep2,
    RegisterStep.kataSandi => Routes.registerStep3,
    RegisterStep.whatsapp => Routes.registerStep4,
  };
}
