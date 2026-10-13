sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

final class NetworkException extends AppException {
  const NetworkException([
    super.message = 'Tidak ada koneksi internet. Periksa jaringan kamu.',
  ]);
}

final class ServerException extends AppException {
  const ServerException(super.message, {this.statusCode});

  final int? statusCode;
}

final class CacheException extends AppException {
  const CacheException([
    super.message = 'Data belum tersedia. Coba muat ulang.',
  ]);
}

final class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Data tidak ditemukan.']);
}

final class AuthException extends AppException {
  const AuthException([
    super.message = 'Sesi kamu sudah berakhir. Silakan masuk kembali.',
  ]);
}

final class UnknownException extends AppException {
  const UnknownException([
    super.message = 'Terjadi kesalahan. Silakan coba lagi.',
  ]);
}
