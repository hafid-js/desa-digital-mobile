class ProfileUser {
  const ProfileUser({
    required this.displayName,
    required this.email,
    required this.fullName,
    required this.formEmail,
    required this.formPhone,
    required this.maskedEmail,
    required this.maskedPhone,
  });

  final String displayName;

  final String email;

  final String fullName;
  final String formEmail;
  final String formPhone;

  final String maskedEmail;

  final String maskedPhone;
}

class ProfileDetail {
  const ProfileDetail({required this.title, required this.value});

  final String title;
  final String value;
}
