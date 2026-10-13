sealed class Failure {
  const Failure(this.message);

  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

final class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Tidak ada koneksi internet. Periksa jaringan kamu.',
  ]);
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode});

  final int? statusCode;
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Data belum tersedia. Coba muat ulang.']);
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {this.fieldErrors = const {}});

  final Map<String, String> fieldErrors;
}

final class AuthFailure extends Failure {
  const AuthFailure([
    super.message = 'Sesi kamu sudah berakhir. Silakan masuk kembali.',
  ]);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Halaman tidak ditemukan.']);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'Terjadi kesalahan. Silakan coba lagi.',
  ]);
}
