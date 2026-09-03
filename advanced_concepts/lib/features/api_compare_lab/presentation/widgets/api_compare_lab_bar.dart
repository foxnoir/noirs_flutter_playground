import 'package:advanced_concepts/features/api_compare_lab/presentation/providers/api_compare_lab_provider.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ApiCompareLabBar extends StatelessWidget {
  const ApiCompareLabBar({
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final ApiCompareLabScenario? selected;
  final ValueChanged<ApiCompareLabScenario> onSelect;

  static const _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _button(
                  context,
                  key: const Key('api-compare-lab-get'),
                  label: l10n.apiCompareGet,
                  value: ApiCompareLabScenario.get,
                ),
                const SizedBox(width: 8),
                _button(
                  context,
                  key: const Key('api-compare-lab-delete'),
                  label: l10n.apiCompareDelete,
                  value: ApiCompareLabScenario.delete,
                ),
                const SizedBox(width: 8),
                _button(
                  context,
                  key: const Key('api-compare-lab-unstable'),
                  label: l10n.apiDioScenarioUnstable,
                  value: ApiCompareLabScenario.unstable,
                ),
                const SizedBox(width: 8),
                _button(
                  context,
                  key: const Key('api-compare-lab-timeout'),
                  label: l10n.apiDioScenarioTimeout,
                  value: ApiCompareLabScenario.timeout,
                ),
                const SizedBox(width: 8),
                _button(
                  context,
                  key: const Key('api-compare-lab-offline'),
                  label: l10n.apiDioScenarioOffline,
                  value: ApiCompareLabScenario.offline,
                ),
                const SizedBox(width: 8),
                _button(
                  context,
                  key: const Key('api-compare-lab-server'),
                  label: l10n.apiDioScenarioServer,
                  value: ApiCompareLabScenario.serverError,
                ),
              ],
            ),
          ),
          if (selected == ApiCompareLabScenario.unstable) ...[
            const SizedBox(height: 8),
            Text(
              l10n.apiCompareUnstableHint,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          if (selected == ApiCompareLabScenario.delete) ...[
            const SizedBox(height: 8),
            Text(
              l10n.apiCompareDeleteHint,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }

  Widget _button(
    BuildContext context, {
    required Key key,
    required String label,
    required ApiCompareLabScenario value,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final isSelected = selected == value;
    return FilledButton(
      key: key,
      style: FilledButton.styleFrom(
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: _shape,
        backgroundColor: isSelected ? scheme.primary : scheme.surface,
        foregroundColor: isSelected
            ? scheme.onPrimary
            : scheme.tertiaryContainer,
      ),
      onPressed: () => onSelect(value),
      child: Text(label),
    );
  }
}
