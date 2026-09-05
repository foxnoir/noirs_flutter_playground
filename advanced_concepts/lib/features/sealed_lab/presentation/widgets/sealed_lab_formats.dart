import 'package:advanced_concepts/features/sealed_lab/domain/book_format.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

abstract final class SealedLabIcons {
  static const selected = 'assets/img/icons/books/book_purple.png';
  static const idle = 'assets/img/icons/books/book_black.png';
}

class SealedLabFormats extends StatefulWidget {
  const SealedLabFormats({super.key});

  @override
  State<SealedLabFormats> createState() => _SealedLabFormatsState();
}

class _SealedLabFormatsState extends State<SealedLabFormats> {
  BookFormat _selected = fourthWingHardcover;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = [fourthWingHardcover, fourthWingPaperback, fourthWingEbook];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final format in formats) ...[
          _FormatTile(
            format: format,
            selected: identical(_selected, format),
            extra: _extra(format, l10n),
            onTap: () => setState(() => _selected = format),
          ),
          const SizedBox(height: 8),
        ],
        Text(
          _switchLine(_selected, l10n),
          key: const Key('sealed-lab-switch'),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }

  String _extra(BookFormat book, AppLocalizations l10n) {
    return switch (book) {
      Hardcover(:final pages) => l10n.sealedPages(pages),
      Paperback(:final massMarket) =>
        massMarket ? l10n.sealedMassMarket : l10n.sealedTrade,
      Ebook(:final megabytes) => l10n.sealedFileSize(megabytes),
    };
  }

  String _label(BookFormat book, AppLocalizations l10n) {
    return switch (book) {
      Hardcover() => l10n.sealedHardcover,
      Paperback() => l10n.sealedPaperback,
      Ebook() => l10n.sealedEbook,
    };
  }

  String _switchLine(BookFormat book, AppLocalizations l10n) {
    return 'switch → ${_label(book, l10n)}';
  }
}

class _FormatTile extends StatelessWidget {
  const _FormatTile({
    required this.format,
    required this.selected,
    required this.extra,
    required this.onTap,
  });

  final BookFormat format;
  final bool selected;
  final String extra;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final name = switch (format) {
      Hardcover() => l10n.sealedHardcover,
      Paperback() => l10n.sealedPaperback,
      Ebook() => l10n.sealedEbook,
    };
    final tileKey = switch (format) {
      Hardcover() => const Key('sealed-lab-hardcover'),
      Paperback() => const Key('sealed-lab-paperback'),
      Ebook() => const Key('sealed-lab-ebook'),
    };

    return Material(
      color: selected
          ? scheme.secondaryContainer
          : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        key: tileKey,
        minLeadingWidth: 56,
        minVerticalPadding: 8,
        leading: Image.asset(
          selected ? SealedLabIcons.selected : SealedLabIcons.idle,
          width: 56,
          height: 56,
          fit: BoxFit.contain,
        ),
        title: Text(format.title),
        subtitle: Text('$name · $extra'),
        selected: selected,
        onTap: onTap,
      ),
    );
  }
}
