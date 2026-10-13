enum ProfileMenuAction {
  profileInfo,
  accountSettings,
  myStore,
  helpCenter,
  termsConditions,
  privacyPolicy,
  rateApp,
}

class ProfileMenuItem {
  const ProfileMenuItem({
    required this.label,
    required this.action,
    this.showDivider = true,
  });

  final String label;
  final ProfileMenuAction action;

  final bool showDivider;
}

class ProfileMenuSection {
  const ProfileMenuSection({required this.title, required this.items});

  final String title;
  final List<ProfileMenuItem> items;
}
