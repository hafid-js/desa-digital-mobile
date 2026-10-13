enum RegisterStep { email, namaLengkap, kataSandi, whatsapp }

extension RegisterStepX on RegisterStep {
  int get nomor => index + 1;

  static int get total => RegisterStep.values.length;
}
