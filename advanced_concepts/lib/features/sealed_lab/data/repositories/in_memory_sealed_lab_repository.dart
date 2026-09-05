import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/sealed_lab/data/data_sources/in_memory_sealed_lab_data_source.dart';
import 'package:advanced_concepts/features/sealed_lab/domain/entities/book_metadata.dart';
import 'package:advanced_concepts/features/sealed_lab/domain/repositories/sealed_lab_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sealedLabRepositoryProvider = Provider<SealedLabRepository>((ref) {
  return InMemorySealedLabRepository(ref.watch(sealedLabDataSourceProvider));
});

/// Maps models → entities and AppException → AppFailure.
class InMemorySealedLabRepository implements SealedLabRepository {
  const InMemorySealedLabRepository(this._dataSource);

  final SealedLabDataSource _dataSource;

  @override
  Future<List<BookMetadata>> fetchFormats() async {
    try {
      final models = await _dataSource.fetchFormats();
      if (models.isEmpty) {
        throw const NotFoundException();
      }
      return [for (final model in models) model.toEntity()];
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }
}
