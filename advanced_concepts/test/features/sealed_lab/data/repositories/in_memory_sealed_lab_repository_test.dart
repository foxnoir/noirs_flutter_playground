import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/sealed_lab/data/data_sources/in_memory_sealed_lab_data_source.dart';
import 'package:advanced_concepts/features/sealed_lab/data/models/book_format_model.dart';
import 'package:advanced_concepts/features/sealed_lab/data/repositories/in_memory_sealed_lab_repository.dart';
import 'package:advanced_concepts/features/sealed_lab/domain/entities/book_metadata.dart';
import 'package:flutter_test/flutter_test.dart';

class _ThrowingSealedLabDataSource implements SealedLabDataSource {
  const _ThrowingSealedLabDataSource(this.exception);

  final AppException exception;

  @override
  Future<List<BookFormatModel>> fetchFormats() async {
    throw exception;
  }
}

void main() {
  test('maps models to entities', () async {
    const repository = InMemorySealedLabRepository(
      InMemorySealedLabDataSource(),
    );

    final formats = await repository.fetchFormats();

    expect(formats, hasLength(3));
    expect(formats.first, isA<Hardcover>());
    expect(formats.first.title, 'Fourth Wing');
  });

  test('maps NetworkException to NetworkFailure', () async {
    const repository = InMemorySealedLabRepository(
      _ThrowingSealedLabDataSource(NetworkException()),
    );

    await expectLater(
      repository.fetchFormats(),
      throwsA(isA<NetworkFailure>()),
    );
  });
}
