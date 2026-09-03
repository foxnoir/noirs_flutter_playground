import 'package:flutter/material.dart';

const busyTapDelay = Duration(seconds: 2);

/// Methods any `State` can pick up. Not a second parent class.
mixin BusyTap<T extends StatefulWidget> on State<T> {
  bool busy = false;

  Future<void> runBusy(Future<void> Function() work) async {
    if (busy) return;
    setState(() => busy = true);
    try {
      await work();
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }
}
