class HomeMenuItem {
  const HomeMenuItem({
    required this.title,
    required this.icon,
    required this.route,
    this.isInDevelopment = false,
  });

  final String title;
  final String icon;
  final String route;
  final bool isInDevelopment;
}
