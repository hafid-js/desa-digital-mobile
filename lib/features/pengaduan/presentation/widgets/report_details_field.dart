import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ReportDetailsField extends StatelessWidget {
  const ReportDetailsField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Rincian Laporan",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              WidgetSpan(child: SizedBox(width: 5)),
              TextSpan(
                text: "Minimal 50 karakter",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
        SizedBox(height: 10),

        TextFormField(
          maxLines: null,
          minLines: 8,
          expands: false,

          decoration: InputDecoration(
            labelText: "Rincian Laporan",
            labelStyle: Theme.of(context).textTheme.labelMedium,
            alignLabelWithHint: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.dark.withAlpha(50),
                width: 1.5,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),
            hintText: "Ceritakan laporan secara lengkap dan jelas",
            hintStyle: Theme.of(context).textTheme.labelMedium,
          ),
        ),

        SizedBox(height: 8),
        Text(
          "Sertakan waktu kejadian dan detail yang diperlukan",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
