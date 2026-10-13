import 'package:desa_digital/features/autentikasi/domain/entities/register_step.dart';
import 'package:desa_digital/features/autentikasi/presentation/controllers/register_controller.dart';
import 'package:desa_digital/features/autentikasi/presentation/widgets/register_step_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterStep1Screen extends StatelessWidget {
  const RegisterStep1Screen({super.key});

  RegisterController get _controller => Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return RegisterStepScaffold(
      judul: "Masukkan Alamat Email",
      subjudul: "Pastikan email aktif jaga-jaga kalau kamu lupa password",
      langkah: RegisterStep.email.nomor,
      field: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        decoration: dekorasiInputRegistrasi(
          hint: "Contoh: hafid.tampan@gmail.com",
        ),
      ),
      onLanjut: () => _controller.goto(RegisterStep.namaLengkap),
      labelLanjut: "Lanjut",
    );
  }
}
