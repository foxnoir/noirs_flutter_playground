import 'package:advanced_concepts/features/sealed_lab/domain/entities/book_metadata.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

String sealedLabFormatName(BookMetadata format, AppLocalizations l10n) {
  return switch (format) {
    Hardcover() => l10n.sealedHardcover,
    Paperback() => l10n.sealedPaperback,
    Ebook() => l10n.sealedEbook,
  };
}

/// Pages, trade vs mass market, or file size — the field that format adds.
String sealedLabFormatDetail(BookMetadata format, AppLocalizations l10n) {
  return switch (format) {
    Hardcover(:final pages) => l10n.sealedPages(pages),
    Paperback(:final massMarket) =>
      massMarket ? l10n.sealedMassMarket : l10n.sealedTrade,
    Ebook(:final megabytes) => l10n.sealedFileSize(megabytes),
  };
}

Key sealedLabBookFormatKey(BookMetadata format) {
  return switch (format) {
    Hardcover() => const Key('sealed-lab-hardcover'),
    Paperback() => const Key('sealed-lab-paperback'),
    Ebook() => const Key('sealed-lab-ebook'),
  };
}
