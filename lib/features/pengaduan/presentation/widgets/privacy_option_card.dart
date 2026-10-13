import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum ComplaintVisibility { private, public }

class PrivacyOptionCard extends StatelessWidget {
  final ComplaintVisibility? selected;
  final ValueChanged<ComplaintVisibility?> onChanged;

  const PrivacyOptionCard({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Jenis Privasi", style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 10),
        Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade300, width: 0.5),
          ),
          child: RadioGroup<ComplaintVisibility>(
            groupValue: selected,
            onChanged: onChanged,
            child: Column(
              children: [
                SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                          ),
                          onTap: () {
                            onChanged(ComplaintVisibility.private);
                          },
                          child: Row(
                            children: [
                              Radio<ComplaintVisibility>(
                                value: ComplaintVisibility.private,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return Colors.green;
                                      }

                                      return Colors.grey;
                                    }),
                              ),

                              const SizedBox(width: 4),

                              const Text(
                                'Privat (Rahasia)',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 0.5,
                        height: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                      Expanded(
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(16),
                          ),
                          onTap: () {
                            onChanged(ComplaintVisibility.public);
                          },
                          child: Row(
                            children: [
                              Radio<ComplaintVisibility>(
                                value: ComplaintVisibility.public,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return Colors.green;
                                      }

                                      return Colors.grey;
                                    }),
                              ),

                              const SizedBox(width: 4),

                              const Text(
                                'Publik',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 0.5, color: Colors.grey.shade300),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(25),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        selected == ComplaintVisibility.private
                            ? Icons.lock_outline_rounded
                            : Icons.public_rounded,
                        color: AppColors.primary.withAlpha(120),
                        size: 25,
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selected == ComplaintVisibility.private
                                  ? 'Aduan Privat (Rahasia)'
                                  : 'Aduan Publik',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),

                            const SizedBox(height: 5),

                            Text(
                              selected == ComplaintVisibility.private
                                  ? 'Aduan hanya dapat diakses olehmu sebagai '
                                        'pelapor dan petugas yang melakukan tindak '
                                        'lanjut. Aduan privat tidak akan terlihat '
                                        'oleh pengguna lain.'
                                  : 'Aduan dapat dilihat oleh pengguna aplikasi '
                                        'Ngopeni Nglakoni lainnya. Pilih opsi ini '
                                        'jika kamu bersedia agar aduanmu dapat '
                                        'dilihat oleh publik.',
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
