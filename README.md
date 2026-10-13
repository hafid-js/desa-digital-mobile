# Desa Digital Mobile

[![Flutter](https://img.shields.io/badge/Flutter-3.38-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%5E3.10-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-lightgrey)](#)
[![Lint](https://img.shields.io/badge/lint-flutter__lints-informational)](https://pub.dev/packages/flutter_lints)

Aplikasi mobile layanan digital warga **Desa Ngopeni Nglakoni** dan **Desa Gunung Condong**. Aplikasi ini menghimpun layanan dan informasi desa dalam satu tempat: layanan administrasi (surat), pengaduan warga, agenda kegiatan, berita, marketplace warga, transparansi APBDes, prakiraan cuaca, hingga peraturan desa.

## Daftar Isi

- [Fitur](#fitur)
- [Teknologi](#teknologi)
- [Arsitektur](#arsitektur)
- [Struktur Proyek](#struktur-proyek)
- [Memulai](#memulai)
- [Pengujian](#pengujian)
- [Pemeriksaan Arsitektur](#pemeriksaan-arsitektur)
- [Gaya Kode](#gaya-kode)
- [Status Proyek](#status-proyek)
- [Kontribusi](#kontribusi)
- [Lisensi](#lisensi)

## Fitur

| Modul | Deskripsi |
|-------|-----------|
| **Autentikasi** | Registrasi bertahap (email, nama, kata sandi, WhatsApp), login, lupa kata sandi, verifikasi OTP |
| **Beranda** | Menu layanan, agenda akan datang, artikel terbaru, ringkasan APBDes, prakiraan cuaca, call center |
| **Agenda** | Kalender kegiatan desa dengan filter berdasarkan jenis (Rapat, Posyandu, Bansos, Kerja Bakti, Keagamaan, dan lainnya) |
| **Artikel** | Daftar dan detail berita/pengumuman desa |
| **Layanan Mandiri** | Permohonan surat mandiri (domisili) dan surat yang perlu proses desa (kelahiran, kematian) beserta unggah persyaratan |
| **Pengaduan** | Pengiriman laporan warga dengan lampiran (foto, PDF, video), penentuan lokasi, dan privasi laporan |
| **Lapak Warga** | Marketplace warga: jual-beli produk, wishlist, pencarian, filter & urutkan berdasarkan kategori/lokasi/harga |
| **Peraturan Desa** | Daftar dan pratinjau dokumen peraturan desa (PDF) |
| **Cuaca** | Prakiraan cuaca per lokasi desa |
| **Notifikasi** | Notifikasi aktivitas dan preferensi notifikasi |
| **Aktivitas** | Riwayat aktivitas pengguna (laporan, berita tersimpan, dsb.) |
| **Profil** | Profil pengguna, ubah data diri, ubah email/telepon/kata sandi, pengaturan akun |

## Teknologi

- **Framework**: Flutter (Dart SDK `^3.10.0`)
- **Manajemen State, Routing & DI**: [GetX](https://pub.dev/packages/get)
- **UI & Widget**: `table_calendar`, `flutter_map` + `latlong2`, `flutter_pdfview`, `dropdown_button2`, `flutter_staggered_grid_view`, `carousel_slider`, `smooth_page_indicator`, `iconsax`, `font_awesome_flutter`, `lucide_icons_flutter`
- **Media & Berkas**: `file_picker`, `image_picker`, `path_provider`, `url_launcher`
- **Utilitas**: `http`, `intl`
- **Kualitas Kode**: `flutter_lints`

## Arsitektur

Proyek ini menerapkan **Clean Architecture** per fitur dengan pemisahan tiga lapisan:

| Lapisan | Tanggung Jawab | Aturan Dependensi |
|---------|----------------|-------------------|
| `domain` | Entity, repository (abstraksi), use case | Tidak bergantung pada lapisan lain |
| `data` | Data source, implementasi repository | Bergantung pada `domain` |
| `presentation` | Controller, screen, widget, binding | Bergantung pada `domain` |

Pola utama yang digunakan:

- **Result** — tipe `sealed class Result<T>` (`Success` / `Failure`) untuk pemulihan kesalahan tanpa exception bocor ke UI (`core/result`).
- **Use Case** — `BaseUseCase<T, P>` dan `BaseAsyncUseCase<T, P>` dengan `NoParams` untuk use case tanpa argumen (`core/usecase`).
- **Dependency Injection** — pembungkus `Injector` di atas GetX (`core/di`), didaftarkan lewat `Binding` per fitur.
- **Feature-first** — setiap fitur mandiri di bawah `lib/features/<nama_fitur>/`.

## Struktur Proyek

```
lib/
├── app/                 # Konfigurasi aplikasi, routing, shell navigasi
│   ├── routes/          # Definisi rute (AppRoutes, AppPages)
│   ├── bindings/        # Binding global
│   ├── app.dart
│   └── main_shell.dart  # Bottom navigation (Home, Aktivitas, Notifikasi, Profil)
├── core/                # Modul lintas fitur
│   ├── constants/       # Warna, aset, konfigurasi
│   ├── di/              # Injector
│   ├── error/           # Failure & pemetaan error
│   ├── result/          # Tipe Result (Success/Failure)
│   ├── theme/           # Tema terang & gelap
│   ├── usecase/         # Kontrak use case
│   ├── utils/           # Utilitas (responsive, dsb.)
│   └── widgets/         # Widget bersama
├── features/            # Fitur aplikasi (feature-first)
│   ├── activity/
│   ├── agenda/
│   ├── artikel/
│   ├── autentikasi/
│   ├── cuaca/
│   ├── home/
│   ├── lapak_warga/
│   ├── notifikasi/
│   ├── pengaduan/
│   ├── peraturan_desa/
│   ├── profil/
│   └── surat/
└── main.dart
```

Struktur tiap fitur yang telah dimigrasikan:

```
features/<fitur>/
├── data/
│   ├── datasources/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bindings/
    ├── controllers/
    ├── screens/
    └── widgets/
```

## Memulai

### Prasyarat

- Flutter **stable** (disarankan 3.38 atau lebih baru)
- Dart SDK `^3.10.0`
- Android Studio (Android) dan/atau Xcode (iOS)
- Perangkat/emulator Android atau iOS

### Instalasi

```bash
git clone https://github.com/hafid-js/desa-digital-mobile.git
cd desa-digital-mobile
flutter pub get
```

### Menjalankan

```bash
# Jalankan di perangkat/emulator
flutter run

# Build rilis
flutter build apk --release     # Android
flutter build ios --release     # iOS
```

## Pengujian

```bash
flutter test
```

Berkas pengujian utama:

- `test/widget_test.dart` — verifikasi aset dan widget bersama
- `test/state_di_layar_test.dart` — pengujian state controller per layar
- `test/layanan_mandiri_test.dart` — pengujian alur layanan surat mandiri

## Pemeriksaan Arsitektur

Skrip memverifikasi kepatuhan dependensi antar-lapisan Clean Architecture:

```bash
dart run tool/architecture_check.dart
```

## Gaya Kode

```bash
# Analisis statis
flutter analyze

# Perbaikan otomatis (jika didukung)
dart fix --apply
```

Aturan lint mengikuti `package:flutter_lints` (lihat `analysis_options.yaml`).

## Status Proyek

> **Catatan:** Saat ini aplikasi menggunakan **data sumber lokal (dummy)** di tiap fitur. Integrasi ke backend belum tersambung, sehingga sebagian alur (mis. pengiriman surat/pengaduan, autentikasi) masih berupa simulasi di sisi klien.

## Kontribusi

1. Buat branch fitur dari `master` (`git checkout -b fitur/nama-fitur`).
2. Ikuti struktur Clean Architecture dan aturan lapisan pada fitur terkait.
3. Pastikan `flutter analyze` dan `flutter test` lolos sebelum membuat pull request.
4. Tulis pesan commit yang ringkas dan deskriptif.

## Lisensi

Proyek ini bersifat internal dan belum memiliki lisensi sumber terbuka. Seluruh hak cipta dilindungi. Hubungi pemilik repositori untuk informasi penggunaan.
