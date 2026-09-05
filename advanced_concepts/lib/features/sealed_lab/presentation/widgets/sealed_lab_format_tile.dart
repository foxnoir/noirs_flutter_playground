import 'package:advanced_concepts/features/sealed_lab/domain/entities/book_metadata.dart';
import 'package:advanced_concepts/features/sealed_lab/presentation/sealed_lab_book_format_labels.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

abstract final class SealedLabBookIcons {
  static const selected = 'assets/img/icons/books/book_purple.png';
  static const idle = 'assets/img/icons/books/book_black.png';
}

class SealedLabFormatTile extends StatelessWidget {
  const SealedLabFormatTile({
    required this.format,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final BookMetadata format;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final name = sealedLabFormatName(format, l10n);
    final detail = sealedLabFormatDetail(format, l10n);

    return Material(
      color: selected
          ? scheme.secondaryContainer
          : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        key: sealedLabBookFormatKey(format),
        minLeadingWidth: 56,
        minVerticalPadding: 8,
        leading: Image.asset(
          selected ? SealedLabBookIcons.selected : SealedLabBookIcons.idle,
          width: 56,
          height: 56,
          fit: BoxFit.contain,
        ),
        title: Text(format.title),
        subtitle: Text('$name · $detail'),
        selected: selected,
        onTap: onTap,
      ),
    );
  }
}
