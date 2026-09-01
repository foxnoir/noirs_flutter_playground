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

final class RequestTimeoutException extends AppException {
  const RequestTimeoutException();
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException();
}

final class ServerException extends AppException {
  const ServerException();
}
