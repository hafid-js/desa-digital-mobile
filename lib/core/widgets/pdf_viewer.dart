import 'dart:io';

import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget {
  final String? pdfPath;

  final String? pdfUrl;

  const PdfViewer({super.key, this.pdfPath, this.pdfUrl})
    : assert(
        pdfPath != null || pdfUrl != null,
        'Path atau URL harus diisi salah satu',
      );

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  String? _localFilePath;
  bool _isLoading = true;
  String _errorMessage = '';
  bool _isDownloading = false;

  int _totalPages = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  Future<void> _initPdf() async {
    try {
      if (widget.pdfPath != null &&
          widget.pdfPath!.startsWith(AppConfig.assetPrefix)) {
        final bytes = await rootBundle.load(widget.pdfPath!);
        final dir = await getTemporaryDirectory();
        final filename = widget.pdfPath!.split('/').last;
        final file = File('${dir.path}/$filename');

        await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);

        setState(() {
          _localFilePath = file.path;
          _isLoading = false;
        });
        return;
      }

      if (widget.pdfPath != null) {
        setState(() {
          _localFilePath = widget.pdfPath;
          _isLoading = false;
        });
        return;
      }

      if (widget.pdfUrl != null) {
        final response = await http.get(Uri.parse(widget.pdfUrl!));
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/$_fileName');

        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          _localFilePath = file.path;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat PDF: $e';
        _isLoading = false;
      });
    }
  }

  String get _fileName {
    final source = widget.pdfPath ?? widget.pdfUrl ?? 'dokumen';
    var name = source.split('/').last.split('?').first;
    if (name.isEmpty) name = 'dokumen.pdf';
    return name.toLowerCase().endsWith('.pdf') ? name : '$name.pdf';
  }

  Future<void> _confirmDownload() async {
    if (_isLoading || _isDownloading) return;

    final fileName = _fileName;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.download_rounded, color: AppColors.primary, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Simpan PDF?",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fileName,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "PDF akan disimpan ke folder downloads dan kamu bisa membagikannya ke aplikasi lain.",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                "Batal",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Simpan",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) return;
    await _handleDownload();
  }

  Future<void> _handleDownload() async {
    final source = _localFilePath;
    if (source == null || _isDownloading) return;

    setState(() => _isDownloading = true);
    try {
      final fileName = _fileName;
      final documentsDir = await getApplicationDocumentsDirectory();
      final downloadDir = Directory('${documentsDir.path}/downloads');
      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }
      final savedFile = await File(
        source,
      ).copy('${downloadDir.path}/$fileName');

      if (!mounted) return;
      _showSaveResult(fileName: fileName, path: savedFile.parent.path);
    } catch (e) {
      if (mounted) _showMessage('Gagal menyimpan PDF: $e', isError: true);
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  void _showSaveResult({required String fileName, required String path}) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.green,
                    size: 26,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "PDF berhasil disimpan",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                fileName,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                path,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.grey,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Buka Files > On My iPhone > Desa Digital > downloads untuk membukanya.",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.textSecondaryLight,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Selesai",
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: Theme.of(context).textTheme.labelSmall),
          backgroundColor: isError ? AppColors.secondary : AppColors.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _totalPages > 0
              ? 'Halaman ${_currentPage + 1} dari $_totalPages'
              : 'Pratinjau PDF',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: 12),
        actions: [
          GestureDetector(
            onTap: _confirmDownload,
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: _isDownloading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (_isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Memuat PDF...'),
                ],
              ),
            );
          }

          if (_errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return Stack(
            children: [
              PDFView(
                filePath: _localFilePath!,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: true,
                pageFling: true,
                pageSnap: true,
                onRender: (pages) {
                  setState(() {
                    _totalPages = pages!;
                  });
                },
                onPageChanged: (page, total) {
                  setState(() {
                    _currentPage = page!;
                  });
                },
                onError: (error) {
                  setState(() {
                    _errorMessage = error.toString();
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
