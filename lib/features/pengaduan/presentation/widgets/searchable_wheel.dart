import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/pengaduan/presentation/controllers/pencarian_wilayah_controller.dart';
import 'package:flutter/material.dart';

class SearchableWheel extends StatefulWidget {
  final PencarianWilayahController controller;
  final int count;

  const SearchableWheel({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  State<SearchableWheel> createState() => _SearchableWheelState();
}

class _SearchableWheelState extends State<SearchableWheel> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.attachScrollListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final count = widget.count;

    return ListWheelScrollView.useDelegate(
      controller: controller.scrollController,
      itemExtent: PencarianWilayahController.itemExtent,
      onSelectedItemChanged: (index) {
        if (index != controller.selectedIndex.value) {
          controller.selectedIndex.value = index;
        }
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: count,
        builder: (context, index) {
          final region = controller.results[index];
          final selected = index == controller.selectedIndex.value;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                controller.pathOf(region),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.primary : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
