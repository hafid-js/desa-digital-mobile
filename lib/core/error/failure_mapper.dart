import 'package:desa_digital/core/error/app_exception.dart';
import 'package:desa_digital/core/error/failure.dart';

Failure mapExceptionToFailure(AppException exception) => switch (exception) {
  NetworkException(:final message) => NetworkFailure(message),
  ServerException(:final message, :final statusCode) => ServerFailure(
    message,
    statusCode: statusCode,
  ),
  CacheException(:final message) => CacheFailure(message),
  NotFoundException(:final message) => NotFoundFailure(message),
  AuthException(:final message) => AuthFailure(message),
  UnknownException(:final message) => UnknownFailure(message),
};

Failure mapUnknownError(Object error) => UnknownFailure(error.toString());
