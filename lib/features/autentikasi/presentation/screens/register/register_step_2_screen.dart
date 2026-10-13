import 'package:desa_digital/features/autentikasi/domain/entities/register_step.dart';
import 'package:desa_digital/features/autentikasi/presentation/controllers/register_controller.dart';
import 'package:desa_digital/features/autentikasi/presentation/widgets/register_step_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterStep2Screen extends StatelessWidget {
  const RegisterStep2Screen({super.key});

  RegisterController get _controller => Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return RegisterStepScaffold(
      judul: "Nama Lengkap",
      subjudul: "Sesuai KTP agar mudah mengakses berbagai layanan",
      langkah: RegisterStep.namaLengkap.nomor,
      field: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.name,
        decoration: dekorasiInputRegistrasi(hint: "Contoh: Hafid Tampan"),
      ),
      onLanjut: () => _controller.goto(RegisterStep.kataSandi),
      labelLanjut: "Lanjut",
    );
  }
}
