import 'package:flutter/material.dart';

const mixinsLabBusyDelay = Duration(seconds: 2);

/// Our mixin — not a Flutter type.
///
/// `runBusy` means: set busy, do the work, clear busy.
/// Each State that `with MixinsLabBusyTap` gets its own `busy`.
mixin MixinsLabBusyTap<T extends StatefulWidget> on State<T> {
  var busy = false;

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
