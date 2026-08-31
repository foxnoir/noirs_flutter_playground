import 'dart:async';

import 'package:advanced_concepts/features/routing_lab/presentation/providers/routing_lab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutingLabSnackBarListener extends ConsumerStatefulWidget {
  const RoutingLabSnackBarListener({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<RoutingLabSnackBarListener> createState() =>
      _RoutingLabSnackBarListenerState();
}

class _RoutingLabSnackBarListenerState
    extends ConsumerState<RoutingLabSnackBarListener> {
  Timer? _hideBanner;

  @override
  void dispose() {
    _hideBanner?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(routingLabProvider, (previous, next) {
      if (next == null) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        final snackTheme = Theme.of(context).snackBarTheme;
        final messenger = ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(
            MaterialBanner(
              backgroundColor: snackTheme.backgroundColor,
              contentTextStyle: snackTheme.contentTextStyle,
              dividerColor: Colors.transparent,
              content: Text(next.call),
              actions: const [SizedBox.shrink()],
            ),
          );
        _hideBanner?.cancel();
        _hideBanner = Timer(const Duration(milliseconds: 2200), () {
          if (!context.mounted) return;
          messenger.hideCurrentMaterialBanner();
        });
      });
    });

    return widget.child;
  }
}
