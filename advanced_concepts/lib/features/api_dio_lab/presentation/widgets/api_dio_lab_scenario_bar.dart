import 'package:advanced_concepts/features/api_dio_lab/presentation/providers/api_dio_lab_provider.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ApiDioLabScenarioBar extends StatelessWidget {
  const ApiDioLabScenarioBar({
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final ApiDioLabScenario? selected;
  final ValueChanged<ApiDioLabScenario> onSelect;

  static final _style = FilledButton.styleFrom(
    visualDensity: VisualDensity.compact,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minimumSize: Size.zero,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                  key: const Key('api-dio-lab-scenario-unstable'),
                  label: l10n.apiDioScenarioUnstable,
                  value: ApiDioLabScenario.unstable,
                ),
                const SizedBox(width: 8),
                _button(
                  key: const Key('api-dio-lab-scenario-timeout'),
                  label: l10n.apiDioScenarioTimeout,
                  value: ApiDioLabScenario.timeout,
                ),
                const SizedBox(width: 8),
                _button(
                  key: const Key('api-dio-lab-scenario-offline'),
                  label: l10n.apiDioScenarioOffline,
                  value: ApiDioLabScenario.offline,
                ),
                const SizedBox(width: 8),
                _button(
                  key: const Key('api-dio-lab-scenario-server'),
                  label: l10n.apiDioScenarioServer,
                  value: ApiDioLabScenario.serverError,
                ),
              ],
            ),
          ),
          if (selected == ApiDioLabScenario.unstable) ...[
            const SizedBox(height: 8),
            Text(
              l10n.apiDioUnstableHint,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }

  Widget _button({
    required Key key,
    required String label,
    required ApiDioLabScenario value,
  }) {
    final isSelected = selected == value;
    if (isSelected) {
      return FilledButton(
        key: key,
        style: _style,
        onPressed: () => onSelect(value),
        child: Text(label),
      );
    }
    return FilledButton.tonal(
      key: key,
      style: _style,
      onPressed: () => onSelect(value),
      child: Text(label),
    );
  }
}
