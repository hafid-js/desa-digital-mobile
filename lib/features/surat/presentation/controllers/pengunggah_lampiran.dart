import 'package:desa_digital/features/surat/presentation/widgets/attachment_source_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PengunggahLampiran extends ChangeNotifier {
  PengunggahLampiran({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  XFile? _file;

  XFile? get file => _file;

  Future<void> pick(BuildContext context) async {
    final source = await showModalBottomSheet<PhotoSource>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const AttachmentSourceSheet(),
    );

    if (source == null || !context.mounted) return;

    final XFile? photo = switch (source) {
      PhotoSource.camera => await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 2000,
        imageQuality: 85,
      ),
      PhotoSource.gallery => await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2000,
        imageQuality: 85,
      ),
    };

    if (photo != null) {
      _file = photo;
      notifyListeners();
    }
  }

  void clear() {
    _file = null;
    notifyListeners();
  }
}
