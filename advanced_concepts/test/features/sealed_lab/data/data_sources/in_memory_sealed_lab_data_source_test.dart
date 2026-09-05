import 'package:advanced_concepts/features/sealed_lab/data/data_sources/in_memory_sealed_lab_data_source.dart';
import 'package:advanced_concepts/features/sealed_lab/data/models/book_format_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fetchFormats returns three Fourth Wing models', () async {
    const source = InMemorySealedLabDataSource();

    final models = await source.fetchFormats();

    expect(models, hasLength(3));
    expect(models[0], isA<HardcoverModel>());
    expect(models[1], isA<PaperbackModel>());
    expect(models[2], isA<EbookModel>());
    expect(models.first.title, 'Fourth Wing');
  });
}
