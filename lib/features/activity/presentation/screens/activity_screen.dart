import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/activity/presentation/widgets/my_reports_section.dart';
import 'package:desa_digital/features/activity/presentation/widgets/saved_section.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Aktivitas",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            overlayColor: WidgetStateProperty.all(
              AppColors.secondary.withAlpha(40),
            ),
            indicatorColor: AppColors.secondary,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.grey,
            labelColor: AppColors.secondary,
            labelStyle: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              borderSide: BorderSide(color: AppColors.secondary, width: 3),
            ),

            tabs: [
              const Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.note_1),
                    SizedBox(width: 6),
                    Text('Laporan Saya'),
                  ],
                ),
              ),
              const Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_outline),
                    SizedBox(width: 6),
                    Text('Disimpan'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [MyReportsSection(), SavedSection()]),
      ),
    );
  }
}
