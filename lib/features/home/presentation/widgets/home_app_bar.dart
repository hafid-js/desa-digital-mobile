import 'dart:async';

import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/utils/color_utils.dart';
import 'package:desa_digital/core/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  late final PageController _pageController;
  Timer? _autoPlayTimer;

  final List<String> sliderItems = [
    AppAssets.banner1,
    AppAssets.banner2,
    AppAssets.banner3,
  ];

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
    return Column(
      children: [
        SizedBox(
          height: 174,
          child: PageView.builder(
            controller: _pageController,
            itemCount: sliderItems.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.zero,
                child: AppRoundedImage(
                  borderRadius: 16,
                  fit: BoxFit.cover,
                  imageUrl: sliderItems[index],
                  isNetworkImage: false,
                  onTap: () {},
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          count: sliderItems.length,
          effect: ExpandingDotsEffect(
            dotHeight: 12,
            dotWidth: 12,
            spacing: 8,
            expansionFactor: 4,
            activeDotColor: HexColor.fromHex("#ff6900"),
            dotColor: AppColors.white,
          ),
          controller: _pageController,
        ),
      ],
    );
  }
}
