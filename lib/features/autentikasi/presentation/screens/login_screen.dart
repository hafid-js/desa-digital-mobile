import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obsecureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  InputDecoration _dekorasiField({
    required IconData prefixIcon,
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(prefixIcon, size: 20, color: Colors.grey),
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w300,
      ),
      floatingLabelStyle: TextStyle(color: AppColors.primary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColors.primary, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColors.primary),
      ),
    );
  }

  ButtonStyle _gayaTombolUtama({
    required Color background,
    required double elevation,
  }) {
    return ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 48),
      backgroundColor: background,
      foregroundColor: background,
      elevation: elevation,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
  }

  TextSpan _spanTeks(
    String text, {
    required Color color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Image.asset("assets/images/logo_main.png", height: 100),
      ),
    );
  }

  Widget _buildJudul(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Sugeng Rawuh",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Masukkan alamat email dan password kamu",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFieldEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: _dekorasiField(
        prefixIcon: Icons.email_rounded,
        hintText: "Masukkan email / no WA",
      ),
    );
  }

  Widget _buildFieldPassword() {
    return TextFormField(
      obscureText: _obsecureText,
      keyboardType: TextInputType.emailAddress,
      decoration: _dekorasiField(
        prefixIcon: Iconsax.key1,
        hintText: "Masukkan password",
        suffixIcon: IconButton(
          onPressed: _togglePasswordVisibility,
          icon: Icon(_obsecureText ? Iconsax.eye : Iconsax.eye_slash),
          color: AppColors.textSecondaryLight,
        ),
      ),
    );
  }

  Widget _buildTombolMasuk(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Get.offAllNamed(Routes.mainShell),
      style: _gayaTombolUtama(background: AppColors.primary, elevation: 0),
      child: Text(
        "Masuk",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLupaPassword() {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.lupaPassword),
      child: Center(
        child: Text(
          "Lupa Password?",
          style: TextStyle(
            fontSize: 13,
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildPemisah() {
    const gayaGaris = Divider(thickness: 0.25, color: Colors.grey);
    const gayaLabel = TextStyle(fontSize: 12, color: Colors.grey);

    return Row(
      children: [
        const Expanded(child: gayaGaris),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('Atau', style: gayaLabel),
        ),
        const Expanded(child: gayaGaris),
      ],
    );
  }

  Widget _buildTombolSosial({
    required FaIconData icon,
    required String label,
    required Color background,
    required Color foreground,
  }) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                "Login dengan $label belum tersedia pada versi ini",
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
      },
      style: _gayaTombolUtama(background: background, elevation: 0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(icon, color: foreground),
          const SizedBox(width: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 15,
              color: foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersetujuan() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          _spanTeks(
            "Dengan masuk ke aplikasi Desa Ngopeni Nglakoni, kamu menyetujui ",
            color: Colors.black87,
            fontSize: 10,
          ),
          _spanTeks(
            "Syarat dan Ketentuan ",
            color: AppColors.secondary,
            fontSize: 10,
          ),
          _spanTeks("serta ", color: Colors.black87, fontSize: 10),
          _spanTeks(
            "Kebijakan Privasi ",
            color: AppColors.secondary,
            fontSize: 10,
          ),
          _spanTeks("yang berlaku.", color: Colors.black87, fontSize: 10),
        ],
      ),
    );
  }

  Widget _buildBelumPunyaAkun() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          _spanTeks(
            "Belum punya akun? ",
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          TextSpan(
            text: "Daftar disini",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.toNamed(Routes.registerStep1),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeader(context),
                    _buildJudul(context),
                    const SizedBox(height: 15),
                    _buildFieldEmail(),
                    const SizedBox(height: 12),
                    _buildFieldPassword(),
                    const SizedBox(height: 12),
                    _buildTombolMasuk(context),
                    const SizedBox(height: 20),
                    _buildLupaPassword(),
                    const SizedBox(height: 20),
                    _buildPemisah(),
                    const SizedBox(height: 20),
                    _buildTombolSosial(
                      icon: FontAwesomeIcons.google,
                      label: "Masuk/Daftar dengan Google",
                      background: AppColors.textPrimaryDark,
                      foreground: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    _buildTombolSosial(
                      icon: FontAwesomeIcons.apple,
                      label: "Masuk/Daftar dengan Apple",
                      background: Colors.black,
                      foreground: AppColors.textPrimaryDark,
                    ),
                    const SizedBox(height: 10),
                    _buildPersetujuan(),
                    const SizedBox(height: 20),
                    _buildBelumPunyaAkun(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
