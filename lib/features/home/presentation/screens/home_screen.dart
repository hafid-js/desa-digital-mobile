import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/features/agenda/domain/entities/event_agenda.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/utils/responsive.dart';
import 'package:desa_digital/core/widgets/app_search_bar.dart';
import 'package:desa_digital/core/widgets/label_pill.dart';
import 'package:desa_digital/features/home/domain/entities/home_menu_item.dart';
import 'package:desa_digital/features/home/presentation/controllers/home_controller.dart';
import 'package:desa_digital/features/home/presentation/widgets/apbdes_section.dart';
import 'package:desa_digital/features/home/presentation/widgets/call_center_card.dart';
import 'package:desa_digital/features/home/presentation/widgets/content_section.dart';
import 'package:desa_digital/features/home/presentation/widgets/cuaca_card.dart';
import 'package:desa_digital/features/home/presentation/widgets/footer.dart';
import 'package:desa_digital/features/home/presentation/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  HomeController get _controller => Get.find<HomeController>();

  Widget _buildBannerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        image: DecorationImage(
          opacity: 0.5,
          image: AssetImage(AppAssets.bannerBackground),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: AppSearchBar(hintText: "Cari layanan apa?"),
              ),
              const SizedBox(width: 15),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(AppAssets.iconTanya),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const HomeAppBar(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, HomeMenuItem menu) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Get.toNamed(menu.route),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(menu.icon, height: 40, width: 40),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              menu.title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Obx(
            () => GridView.count(
              crossAxisCount: Responsive.gridColumns(
                context,
                phone: 4,
                tablet: 4,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: Responsive.value(
                context,
                phone: 12,
                tablet: 16,
              ),
              mainAxisSpacing: Responsive.value(context, phone: 12, tablet: 16),
              childAspectRatio: Responsive.value(
                context,
                phone: 0.8,
                tablet: 1.0,
              ),
              padding: EdgeInsets.zero,
              children: _controller.menuItems
                  .map((menu) => _buildMenuItem(context, menu))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrakiraanCuaca(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      titleAlignment: ListTileTitleAlignment.top,
      title: Text(
        "Prakiraan Cuaca",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        "Sabtu, 03 Oktober 2026 21:00",
        style: Theme.of(context).textTheme.labelSmall,
      ),
      trailing: UnconstrainedBox(
        child: LabelPill(
          label: "Semua Desa",
          color: AppColors.primary,
          backgroundColor: AppColors.primary.withAlpha(40),
          icon: Iconsax.arrow_right_3,
          action: () => Get.toNamed(Routes.cuaca),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ContentSection(
            title: "Agenda Hari Ini",
            items: _controller.agendaHariIni,
            padding: const EdgeInsets.only(left: 15, top: 5, bottom: 8),
            onButtonPressed: () => Get.toNamed(Routes.agenda),
            onTap: (item) => Get.toNamed(
              Routes.detailAgenda,
              arguments: EventAgenda(
                title: item.title,
                image: item.image,
                date: item.date,
                lokasi: "Desa Gunung Condong",
                penyelenggara: "Panitia Agenda Desa",
                deskripsi:
                    "Agenda desa. Detail lengkap akan tersedia setelah app terhubung ke server desa.",
              ),
            ),
          ),
          const SizedBox(height: 20),
          ContentSection(
            title: "Artikel Terbaru",
            items: _controller.artikelTerbaru,
            padding: const EdgeInsets.only(left: 15, top: 5, bottom: 20),
            onButtonPressed: () => Get.toNamed(Routes.artikel),
            onTap: (item) {},
          ),
          const SizedBox(height: 8),
          if (_controller.ringkasanApbdes.value != null)
            ApbdesSection(summary: _controller.ringkasanApbdes.value!),
          const Footer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  _buildBannerSection(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        const CallCenterCard(),
                        const SizedBox(height: 20),
                        _buildMenuSection(context),
                        const SizedBox(height: 20),
                        _buildPrakiraanCuaca(context),
                        const CuacaCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildContent(context),
          ],
        ),
      ),
    );
  }
}
