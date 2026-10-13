import 'package:desa_digital/features/autentikasi/domain/entities/register_step.dart';
import 'package:desa_digital/features/autentikasi/presentation/controllers/register_controller.dart';
import 'package:desa_digital/features/autentikasi/presentation/widgets/register_step_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterStep2Screen extends StatefulWidget {
  const RegisterStep2Screen({super.key});

  @override
  State<RegisterStep2Screen> createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
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

  @override
  Widget build(BuildContext context) {
    return RegisterStepScaffold(
      judul: "Nama Lengkap",
      subjudul: "Sesuai KTP agar mudah mengakses berbagai layanan",
      langkah: RegisterStep.namaLengkap.nomor,
      field: TextFormField(
        focusNode: _focusNode,
        keyboardType: TextInputType.name,
        decoration: dekorasiInputRegistrasi(hint: "Contoh: Hafid Tampan"),
      ),
      onLanjut: () => _controller.goto(RegisterStep.kataSandi),
      labelLanjut: "Lanjut",
    );
  }
}
