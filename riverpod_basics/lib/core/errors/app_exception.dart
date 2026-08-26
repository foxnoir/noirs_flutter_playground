/// Thrown by data sources. The repository maps this to AppFailure.
sealed class AppException implements Exception {
  const AppException();
}

final class NetworkException extends AppException {
  const NetworkException();
}

final class NotFoundException extends AppException {
  const NotFoundException();
}

/// Playground-only: AsyncNotifier Persistent State, every 3rd page enter.
/// That demo has no data source; the notifier throws this itself.
final class FakePageEnterException extends AppException {
  const FakePageEnterException(this.visitCount);

  final int visitCount;
}
