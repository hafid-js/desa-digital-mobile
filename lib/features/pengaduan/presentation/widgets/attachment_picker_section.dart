import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:desa_digital/features/pengaduan/presentation/screens/detail_lampiran_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentPickerSection extends StatelessWidget {
  final ValueChanged<String>? onLampiranSelesai;
  final ValueChanged<PlatformFile> onPdfPicked;
  final ValueChanged<PlatformFile> onVideoPicked;
  final ValueChanged<XFile> onPhotoPicked;

  const AttachmentPickerSection({
    super.key,
    this.onLampiranSelesai,
    required this.onPdfPicked,
    required this.onVideoPicked,
    required this.onPhotoPicked,
  });

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
                text: "Lampiran Foto/Video/PDF",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              WidgetSpan(child: SizedBox(width: 5)),
              TextSpan(
                text: "Maks.3",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Get.to<void>(
                  () => DetailLampiranScreen(
                    jenis: "foto",
                    onSelesai: onLampiranSelesai,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppAssets.complaintExample,
                          height: 100,
                          width: 120,
                          fit: BoxFit.cover,
                        ),

                        Container(
                          width: double.infinity,
                          color: AppColors.secondary,
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.edit,
                                color: Colors.white,
                                size: 14,
                                weight: 30,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Edit",
                                style: Theme.of(context).textTheme.labelSmall!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () => Get.to<void>(
                  () => DetailLampiranScreen(
                    jenis: "pdf",
                    onSelesai: onLampiranSelesai,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 100,
                          width: 120,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withAlpha(30),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.filePdf,
                                  color: AppColors.textPrimaryLight,
                                  size: 25,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Lorem_Ipsum_is_simply_dummy_text_of_the_printing.pdf",
                                  style: Theme.of(context).textTheme.labelSmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: AppColors.secondary,
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.edit,
                                color: Colors.white,
                                size: 14,
                                weight: 30,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Edit",
                                style: Theme.of(context).textTheme.labelSmall!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),

              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (context) {
                      return _UploadAttachmentSheet(
                        onPdfPicked: onPdfPicked,
                        onVideoPicked: onVideoPicked,
                        onPhotoPicked: onPhotoPicked,
                      );
                    },
                  );
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 35,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UploadAttachmentSheet extends StatelessWidget {
  final ValueChanged<PlatformFile> onPdfPicked;
  final ValueChanged<PlatformFile> onVideoPicked;
  final ValueChanged<XFile> onPhotoPicked;

  const _UploadAttachmentSheet({
    required this.onPdfPicked,
    required this.onVideoPicked,
    required this.onPhotoPicked,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return DraggableScrollableSheet(
          expand: false,

          initialChildSize: 0.27,
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
                    "Unggah Lampiran",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Pilih jenis lampiran yang akan kamu unggah.",
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
                              onPressed: () async {
                                final PlatformFile? file =
                                    await FilePicker.pickFile(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf'],
                                    );

                                if (file != null) {
                                  onPdfPicked(file);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary.withAlpha(
                                  40,
                                ),
                                foregroundColor: AppColors.primary,
                                elevation: 0,
                                side: BorderSide.none,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.insert_drive_file_rounded,
                                    size: 20,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    "File PDF",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
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
                              onPressed: () async {
                                final PlatformFile? file =
                                    await FilePicker.pickFile(
                                      type: FileType.video,
                                    );

                                if (file != null) {
                                  onVideoPicked(file);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary.withAlpha(
                                  40,
                                ),
                                foregroundColor: AppColors.primary,
                                elevation: 0,
                                side: BorderSide.none,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.video_file_rounded,
                                    size: 20,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    "File Video",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();

                      final XFile? image = await picker.pickImage(
                        source: ImageSource.camera,
                      );

                      if (image != null) {
                        debugPrint('Foto: ${image.path}');

                        onPhotoPicked(image);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      side: BorderSide.none,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Ambil Foto",
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
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
