import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/cuaca/presentation/controllers/weather_controller.dart';
import 'package:desa_digital/features/cuaca/presentation/widgets/section_cuaca.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

const List<({double radiusIkon, double radiusKartu})> _radiusBagian = [
  (radiusIkon: 12, radiusKartu: 12),
  (radiusIkon: 8, radiusKartu: 8),
  (radiusIkon: 8, radiusKartu: 8),
  (radiusIkon: 8, radiusKartu: 8),
  (radiusIkon: 8, radiusKartu: 8),
];

class CuacaScreen extends StatelessWidget {
  const CuacaScreen({super.key});

  WeatherController get _controller => Get.find<WeatherController>();

  PreferredSize _buildPencarian(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => TextFormField(
            autofocus: true,
            keyboardType: TextInputType.name,
            controller: _controller.searchController,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search, color: Colors.black87),
              hint: Text(
                "Cari lokasi",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              floatingLabelStyle: TextStyle(color: AppColors.primary),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.grey.withAlpha(180),
                  width: 1.5,
                ),
              ),
              suffixIcon: _controller.query.value.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Iconsax.close_circle5,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: _controller.clearSearch,
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.grey.withAlpha(180),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Prakiraan Cuaca",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        bottom: _buildPencarian(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Obx(
                () => Column(
                  children: [
                    for (
                      var index = 0;
                      index < _controller.lokasi.length;
                      index++
                    ) ...[
                      SectionCuaca(
                        lokasi: _controller.lokasi[index],
                        radiusIkon: _radiusBagian[index].radiusIkon,
                        radiusKartu: _radiusBagian[index].radiusKartu,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
