import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/activity/presentation/screens/activity_screen.dart';
import 'package:desa_digital/features/home/presentation/screens/home_screen.dart';
import 'package:desa_digital/features/notifikasi/presentation/screens/notifikasi_screen.dart';
import 'package:desa_digital/features/profil/presentation/screens/profil_screen.dart';
import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static const List<_ShellTab> _tabs = [
    _ShellTab(label: 'Home', icon: Icons.home_rounded),
    _ShellTab(label: 'Aktivitas', icon: Icons.list_alt),
    _ShellTab(label: 'Notifications', icon: Icons.notifications_none_rounded),
    _ShellTab(label: 'Profil', icon: Icons.person_outline),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  Widget _buildTabContent(int index) => switch (index) {
    0 => const HomeScreen(),
    1 => const ActivityScreen(),
    2 => const NotifikasiScreen(),
    _ => const ProfilScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: _buildTabContent(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedIconTheme: const IconThemeData(size: 25),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppColors.white,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        items: [
          for (final tab in _tabs)
            BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.label),
        ],
      ),
    );
  }
}

class _ShellTab {
  const _ShellTab({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
