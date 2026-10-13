import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SubmitSection extends StatelessWidget {
  const SubmitSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return const _KonfirmasiKirimSheet();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.primary,
              elevation: 0,
              side: BorderSide.none,
            ),
            child: Text(
              "Kirim Laporan",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _KonfirmasiKirimSheet extends StatelessWidget {
  const _KonfirmasiKirimSheet();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return DraggableScrollableSheet(
          expand: false,

          initialChildSize: 0.22,
          minChildSize: 0.2,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Yakin ingin mengirim laporan?",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Pastikan informasi yang akan kamu laporkan sudah benar dan lengkap.",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 42,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  width: 0.2,
                                  color: AppColors.secondary,
                                ),
                                right: BorderSide(
                                  width: 0.2,
                                  color: AppColors.secondary,
                                ),
                                bottom: BorderSide(
                                  width: 0.2,
                                  color: AppColors.secondary,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary.withAlpha(
                                  40,
                                ),
                                foregroundColor: AppColors.secondary.withAlpha(
                                  40,
                                ),
                                elevation: 0,
                                side: BorderSide.none,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Tinjau Ulang",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: AppColors.secondary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: SizedBox(
                          height: 42,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  width: 0.2,
                                  color: AppColors.primary,
                                ),
                                right: BorderSide(
                                  width: 0.2,
                                  color: AppColors.primary,
                                ),
                                bottom: BorderSide(
                                  width: 0.2,
                                  color: AppColors.primary,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                      content: Text("Laporan berhasil dikirim"),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.primary,
                                elevation: 0,
                                side: BorderSide.none,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Ya, Kirim",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
