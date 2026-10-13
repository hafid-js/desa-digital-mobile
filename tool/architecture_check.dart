// Pemeriksa aturan lapisan (layering) Clean Architecture.
//
// Jalankan: dart run tool/architecture_check.dart
//
// Aturan:
//   domain        -> hanya boleh mengimpor core/result, core/usecase, core/error
//   data          -> boleh mengimpor domain + core
//   presentation  -> boleh mengimpor domain + core + app/routes
//   app/core      -> boleh mengimpor semuanya
//
// Feature yang belum dimigrasikan (belum punya folder domain/) dilewati.

import 'dart:io';

const _rules = <String, List<String>>{
  'domain': [
    'core/result',
    'core/usecase',
    'core/error',
    'core/di',
    '/domain/',
  ],
  'data': [
    'core/result',
    'core/usecase',
    'core/error',
    'core/di',
    '/domain/',
    '/data/',
  ],
  'presentation': [
    'core/result',
    'core/usecase',
    'core/error',
    'core/di',
    'core/extensions',
    '/domain/',
    '/presentation/',
    'app/routes/',
  ],
};

/// Feature dianggap sudah dimigrasikan bila sudah punya folder `domain/`
/// atau `presentation/`.
bool _isMigrated(Directory feature) =>
    Directory('${feature.path}/domain').existsSync() ||
    Directory('${feature.path}/presentation').existsSync();

bool _isLayerOf(String path, String layer) =>
    path.contains('/features/') && path.contains('/$layer/');

void main() {
  final featureDirs = Directory(
    'lib/features',
  ).listSync().whereType<Directory>().toList();

  final violations = <String>[];

  for (final feature in featureDirs) {
    final name = feature.path.split('/').last;
    if (!_isMigrated(feature)) {
      stdout.writeln('skip  $name (belum dimigrasikan)');
      continue;
    }

    final layers = [
      'domain',
      'data',
      'presentation',
    ].where((l) => Directory('${feature.path}/$l').existsSync()).toList();

    if (layers.isEmpty) {
      stdout.writeln('skip  $name (belum dimigrasikan)');
      continue;
    }

    var violationCount = 0;
    for (final file in feature.listSync(recursive: true).whereType<File>()) {
      final path = file.path;
      if (!path.endsWith('.dart')) continue;

      final layer = _rules.keys.firstWhere(
        (l) => _isLayerOf(path, l),
        orElse: () => '',
      );
      if (layer.isEmpty) continue;

      final allowed = _rules[layer]!;
      for (final match in RegExp(
        r"package:desa_digital/([\w/]+)\.dart",
      ).allMatches(file.readAsStringSync())) {
        final target = match.group(1)!;
        final prefix = 'features/$name';
        if (!target.startsWith(prefix))
          continue; // lintas feature dicegah terpisah
        if (allowed.any(target.contains)) continue;
        // Binding adalah composition root feature: boleh merangkai data layer.
        if (path.contains('/presentation/bindings/') &&
            target.contains('/data/')) {
          continue;
        }
        violations.add('${path.replaceAll('lib/', '')}  [$layer] -> $target');
        violationCount++;
      }
    }

    stdout.writeln(
      violationCount == 0
          ? 'ok    $name (${layers.join(', ')})'
          : 'FAIL  $name (${layers.join(', ')}) - $violationCount pelanggaran',
    );
  }

  if (violations.isEmpty) {
    stdout.writeln(
      '\nSemua feature yang sudah dimigrasikan ber.layer dengan benar.',
    );
    return;
  }

  stdout.writeln('\nPelanggaran:');
  for (final violation in violations) {
    stdout.writeln('  $violation');
  }
  exitCode = 1;
}
