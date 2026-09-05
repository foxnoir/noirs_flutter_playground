import 'package:advanced_concepts/features/sealed_lab/data/repositories/in_memory_sealed_lab_repository.dart';
import 'package:advanced_concepts/features/sealed_lab/domain/entities/book_metadata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

@immutable
class SealedLabBookFormatState {
  const SealedLabBookFormatState({
    required this.formats,
    required this.selected,
  });

  final List<BookMetadata> formats;
  final BookMetadata selected;
}

final sealedLabBookFormatProvider =
    AsyncNotifierProvider<
      SealedLabBookFormatNotifier,
      SealedLabBookFormatState
    >(SealedLabBookFormatNotifier.new);

class SealedLabBookFormatNotifier
    extends AsyncNotifier<SealedLabBookFormatState> {
  @override
  Future<SealedLabBookFormatState> build() async {
    final formats = await ref.watch(sealedLabRepositoryProvider).fetchFormats();
    return SealedLabBookFormatState(formats: formats, selected: formats.first);
  }

  void select(BookMetadata format) {
    final current = state.value;
    if (current == null || current.selected == format) return;
    state = AsyncData(
      SealedLabBookFormatState(formats: current.formats, selected: format),
    );
  }
}
