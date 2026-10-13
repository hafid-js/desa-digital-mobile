import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/autentikasi/domain/entities/register_step.dart';
import 'package:desa_digital/features/autentikasi/presentation/controllers/register_controller.dart';
import 'package:desa_digital/features/autentikasi/presentation/widgets/register_step_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RegisterStep4Screen extends StatelessWidget {
  const RegisterStep4Screen({super.key});

  RegisterController get _controller => Get.find<RegisterController>();

  Widget _buildFieldWhatsapp() {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.phone,
      decoration: dekorasiInputRegistrasi(hint: "08XXXXXXXXXX"),
    );
  }

  Widget _buildInfoSyarat() {
    const gayaTeks = TextStyle(fontSize: 11, color: Colors.black87);
    final gayaTeksTautan = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColors.secondary,
    );

    return Row(
      children: [
        Icon(Iconsax.info_circle5, color: AppColors.tertiary),
        const SizedBox(width: 9),
        Expanded(
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Dengan klik Daftar & Kirim Kode, kamu menyetujui ",
                  style: gayaTeks,
                ),
                TextSpan(
                  text: "Syarat dan Ketentuan ",
                  style: gayaTeksTautan,
                ),
                TextSpan(text: "serta ", style: gayaTeks),
                TextSpan(text: "Kebijakan Privasi ", style: gayaTeksTautan),
                TextSpan(text: "yang berlaku.", style: gayaTeks),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegisterStepScaffold(
      judul: "Masukkan No. Whatsapp",
      subjudul: "Pastikan whatsapp aktif untuk menerima kode verifikasi",
      langkah: RegisterStep.whatsapp.nomor,
      field: _buildFieldWhatsapp(),
      onLanjut: _controller.gotoVerifikasiOtp,
      labelLanjut: "Daftar & Kirim Kode",
      infoTambahan: _buildInfoSyarat(),
    );
  }
}
