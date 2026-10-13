import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/autentikasi/presentation/controllers/register_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<RegisterController>(RegisterController.new, lazy: true);
  }
}
