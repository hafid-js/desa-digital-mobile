import 'package:desa_digital/features/autentikasi/domain/entities/register_step.dart';
import 'package:desa_digital/features/autentikasi/presentation/controllers/register_controller.dart';
import 'package:desa_digital/features/autentikasi/presentation/widgets/register_step_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterStep3Screen extends StatefulWidget {
  const RegisterStep3Screen({super.key});

  @override
  State<RegisterStep3Screen> createState() => _RegisterStep3ScreenState();
}

class _RegisterStep3ScreenState extends State<RegisterStep3Screen> {
  final FocusNode _focusNode = FocusNode();
  RegisterController get _controller => Get.find<RegisterController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  InputDecoration _dekorasiPassword(bool sembunyikanPassword) {
    return dekorasiInputRegistrasi(
      hint: "Minimal 8 karakter",
      suffixIcon: IconButton(
        icon: Icon(
          sembunyikanPassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: _controller.togglePassword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegisterStepScaffold(
      judul: "Buat Password",
      subjudul: "Gunakan kombinasi angka dan huruf",
      langkah: 3,
      field: Obx(
        () => TextFormField(
          focusNode: _focusNode,
          obscureText: _controller.sembunyikanPassword.value,
          keyboardType: TextInputType.visiblePassword,
          decoration: _dekorasiPassword(_controller.sembunyikanPassword.value),
        ),
      ),
      onLanjut: () => _controller.goto(RegisterStep.whatsapp),
      labelLanjut: "Lanjut",
      langkahFontWeight: null,
    );
  }
}
