import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LapakAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LapakAppBar({
    super.key,
    required this.title,
    required this.searchHint,
    this.preferredHeight = 60,
    this.extraActions = const <Widget>[],
    this.bottom,
  });

  final String title;
  final String searchHint;
  final double preferredHeight;
  final List<Widget> extraActions;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);

  @override
  State<LapakAppBar> createState() => _LapakAppBarState();
}

class _LapakAppBarState extends State<LapakAppBar> {
  bool _isSearch = false;

  void _toggleSearch() => setState(() => _isSearch = !_isSearch);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: false,
      title: LayoutBuilder(
        builder: (context, constraints) {
          final searchWidth = constraints.maxWidth;

          return SizedBox(
            width: constraints.maxWidth,
            height: 48,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 590),
                  curve: Curves.easeInOut,
                  width: _isSearch ? 0 : searchWidth,
                  height: 22,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    width: _isSearch ? searchWidth : 0,
                    height: 44,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 150),
                      opacity: _isSearch ? 1 : 0,
                      child: _searchField(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      actionsPadding: const EdgeInsets.only(right: 6),
      actions: [
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: _toggleSearch,
          icon: Icon(
            _isSearch ? Iconsax.close_circle : Iconsax.search_normal_1,
          ),
          tooltip: 'Search',
        ),
        ...widget.extraActions,
      ],
      bottom: widget.bottom,
    );
  }

  Widget _searchField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        hintText: widget.searchHint,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: TextStyle(color: AppColors.primary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        suffixIcon: const Icon(
          Iconsax.search_normal_1,
          size: 20,
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
