import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/rounded_image.dart';
import 'package:desa_digital/features/lapak_warga/data/datasources/opsi_lapak_data_source.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/produk_lapak.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/sheet_form_lapak.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LapakItemSayaCard extends StatefulWidget {
  const LapakItemSayaCard({
    super.key,
    required this.product,
    required this.onTap,
    this.isPelapakDetail = false,
  });

  final ProdukLapak product;
  final VoidCallback onTap;
  final bool isPelapakDetail;

  @override
  State<LapakItemSayaCard> createState() => _LapakItemSayaCardState();
}

class _LapakItemSayaCardState extends State<LapakItemSayaCard> {
  bool isFavorite = false;

  Future<void> _editJual(BuildContext context) async {
    final opsi = const OpsiLapakDataSource().loadOpsi();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.95,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, scrollController) => SheetFormLapak(
          judul: "Edit Produk",
          kategori: opsi.kategoriProduk,
          kondisi: opsi.kondisiProduk,
          lokasi: opsi.lokasi,
          scrollController: scrollController,
        ),
      ),
    );
  }

  void _dialogHapus(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: 1.58,
              child: Container(
                width: 230,
                height: 290,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Transform.rotate(
              angle: 1.5,
              child: Container(
                width: 230,
                height: 290,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),
              icon: const Icon(Iconsax.info_circle5, size: 50),
              content: Text(
                'Apakah kamu yakin ingin menghapus produk ini?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              width: 0.5,
                              color: AppColors.grey,
                            ),
                          ),
                          child: Text(
                            'Tidak',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Ya',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        product.image,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (product.discount.isNotEmpty)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            ),
                          ),
                          child: Text(
                            product.discount,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => _editJual(context),
                      child: Icon(
                        Icons.edit,
                        color: AppColors.secondary,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Rp",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          TextSpan(
                            text: product.price,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _dialogHapus(context),
                      child: const Icon(
                        Icons.delete_rounded,
                        size: 25,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                if (!widget.isPelapakDetail)
                  Row(
                    children: [
                      AppRoundedImage(
                        imageUrl: product.userAvatar,
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.seller,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(
                                    color: AppColors.textSecondaryLight,
                                    fontSize: 10,
                                  ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 11,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    product.location,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          fontSize: 10,
                                          color: AppColors.textSecondaryLight,
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
        ),
      ),
    );
  }
}
