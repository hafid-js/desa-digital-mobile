import 'package:desa_digital/core/result/result.dart';

abstract interface class UseCase<T, P> {
  Result<T> call(P params);
}

abstract class BaseUseCase<T, P> implements UseCase<T, P> {
  const BaseUseCase();

  @override
  Result<T> call(P params) => execute(params);

  Result<T> execute(P params);
}

abstract interface class AsyncUseCase<T, P> {
  Future<Result<T>> call(P params);
}

abstract class BaseAsyncUseCase<T, P> implements AsyncUseCase<T, P> {
  const BaseAsyncUseCase();

  @override
  Future<Result<T>> call(P params) => execute(params);

  Future<Result<T>> execute(P params);
}

final class NoParams {
  const NoParams();
}
