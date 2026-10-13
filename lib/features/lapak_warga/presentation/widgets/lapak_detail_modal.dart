import 'dart:async';

import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/rounded_image.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/produk_lapak.dart';
import 'package:desa_digital/features/lapak_warga/presentation/screens/detail_pelapak_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LapakDesaDetailModal extends StatefulWidget {
  final ProdukLapak product;
  final ScrollController scrollController;

  const LapakDesaDetailModal({
    super.key,
    required this.product,
    required this.scrollController,
  });

  @override
  State<LapakDesaDetailModal> createState() => _LapakDesaDetailModalState();
}

class _LapakDesaDetailModalState extends State<LapakDesaDetailModal> {
  late final PageController _pageController;
  Timer? _autoPlayTimer;

  final List<String> sliderItems = [
    AppAssets.example1,
    AppAssets.example1,
    AppAssets.example1,
  ];
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      int nextPage = _pageController.page!.round() + 1;
      if (nextPage >= sliderItems.length) nextPage = 0;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black, size: 25),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Detail", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AspectRatio(
                    aspectRatio: 1.4,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: sliderItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AppRoundedImage(
                              fit: BoxFit.cover,
                              imageUrl: sliderItems[index],
                              isNetworkImage: false,
                              onTap: () {},
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    count: sliderItems.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 6,
                      expansionFactor: 3,
                      activeDotColor: AppColors.secondary,
                      dotColor: AppColors.primary,
                    ),
                    controller: _pageController,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.product.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Icon(
                              isFavorite ? Iconsax.heart5 : Iconsax.heart,
                              color: isFavorite
                                  ? Colors.redAccent
                                  : Colors.black87,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Rp",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.product.price,
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Iconsax.ticket,
                            size: 14,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "Rp${widget.product.originalPrice}",
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Deskripsi",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "iPhone 17 memiliki kamera Utama Fusion 48 MP dengan 2x telefoto kualitas optik, dan kamera Ultra Wide Fusion 48 MP dengan 4x resolusi kamera Ultra Wide di iPhone 16. Dan kini foto Ultra Wide memiliki resolusi 24 MP secara default, ukuran file yang tepat untuk berbagi dan penyimpanan kualitas tinggi. Jadi, Anda akan mendapatkan foto memukau dengan resolusi super tinggi — dari jarak dekat maupun jauh, di dalam maupun di luar ruangan, dengan pencahayaan terang hingga rendah. Disertai kapasitas penyimpanan 256 GB, dua kali lipat kemampuan penyimpanan awal model sebelumnya. Jadi, Anda bisa berkreasi sesuka hati — dan banyak lagi.",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: AppColors.textSecondaryLight,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: () => Get.to(
                          () => DetailPelapakScreen(produk: widget.product),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Penjual",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(width: 8),
                                const Icon(Iconsax.arrow_right_3, size: 13),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                AppRoundedImage(
                                  imageUrl: widget.product.userAvatar,
                                  height: 35,
                                  width: 35,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.product.seller,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 11,
                                            color: AppColors.secondary,
                                          ),
                                          const SizedBox(width: 2),
                                          Expanded(
                                            child: Text(
                                              widget.product.location,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                    fontSize: 12,
                                                    color: AppColors
                                                        .textSecondaryLight,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(color: Colors.white),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Kontak penjual tersedia setelah app terhubung ke server desa",
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                    },
                    icon: FaIcon(FontAwesomeIcons.whatsapp),
                    label: Text(
                      'Hubungi Penjual (WhatsApp)',
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
