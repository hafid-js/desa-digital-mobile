import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LangkahProgresPengaduan extends StatelessWidget {
  final String status;
  final String admin;
  final String date;
  final String description;

  const LangkahProgresPengaduan({
    super.key,
    required this.status,
    required this.admin,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = status == "Disposisi"
        ? AppColors.primary
        : status == "Verifikasi"
        ? AppColors.tertiary
        : status == "Progress"
        ? AppColors.secondary
        : status == "Selesai"
        ? AppColors.quartenary
        : Colors.grey;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: status == "Disposisi"
                      ? AppColors.primary
                      : status == "Verifikasi"
                      ? AppColors.tertiary
                      : status == "Progress"
                      ? AppColors.secondary
                      : status == "Selesai"
                      ? AppColors.quartenary
                      : Colors.grey,
                  width: 6,
                ),
              ),
            ),
            Container(width: 2, height: 120, color: Colors.grey.withAlpha(80)),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                admin,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(date, style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100],
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              if (status == "Progress" || status == "Selesai") ...[
                const SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: BoxBorder.all(width: 0.3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.sim_card_download_outlined, size: 20),
                      SizedBox(width: 5),
                      Text(
                        "2629892397299723.pdf",
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall!.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
