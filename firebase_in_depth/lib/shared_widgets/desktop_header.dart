import 'package:firebase_in_depth/core/router/app_router_names.dart';
import 'package:firebase_in_depth/core/theme/app_breakpoint.dart';
import 'package:firebase_in_depth/features/auth/presentation/widgets/desktop_header_account.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DesktopHeader extends StatelessWidget {
  const DesktopHeader({this.currentRoute, super.key});

  final String? currentRoute;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.94),
        border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
      ),
      child: Align(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoint.contentMax),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _HeaderLink(
                        label: l10n.navHome,
                        selected: currentRoute == AppRouteNames.landing,
                        style: Theme.of(context).textTheme.titleLarge,
                        onTap: () => _go(context, AppRouteNames.landing),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _HeaderLink(
                            label: l10n.navFundamentals,
                            selected:
                                currentRoute == AppRouteNames.fundamentals,
                            onTap: () =>
                                _go(context, AppRouteNames.fundamentals),
                          ),
                          const SizedBox(width: 20),
                          _HeaderLink(
                            label: l10n.navLab,
                            selected: currentRoute == AppRouteNames.home,
                            onTap: () => _go(context, AppRouteNames.home),
                          ),
                          const SizedBox(width: 24),
                          DesktopHeaderAccount(currentRoute: currentRoute),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _go(BuildContext context, String name) {
    final router = GoRouter.maybeOf(context);
    if (router == null) return;
    context.goNamed(name);
  }
}

class _HeaderLink extends StatelessWidget {
  const _HeaderLink({
    required this.label,
    required this.selected,
    required this.onTap,
    this.style,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = style ?? Theme.of(context).textTheme.labelLarge;
    final color = selected ? scheme.primary : scheme.onSurface;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? scheme.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: base?.copyWith(color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
