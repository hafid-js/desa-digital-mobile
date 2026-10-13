import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  bool isFavorite = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Daftar Keinginan Saya",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 12, left: 8),
                leading: AppRoundedImage(
                  borderRadius: 12,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  imageUrl: "assets/images/lapak_warga/produk-example-1.png",
                ),
                title: Text(
                  "Suplemen High Protein $index",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Row(
                  children: [
                    Text(
                      "Mardiyanto",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(" - "),
                    Icon(Icons.location_on, size: 11, color: AppColors.primary),
                    const SizedBox(width: 2),
                    Text(
                      "Dusun Karangsari",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                trailing: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Icon(
                    isFavorite ? Iconsax.heart5 : Iconsax.heart,
                    color: isFavorite
                        ? AppColors.secondary
                        : AppColors.textSecondaryLight,
                    size: 18,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
