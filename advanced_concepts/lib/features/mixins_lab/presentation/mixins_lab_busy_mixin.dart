import 'package:flutter/material.dart';

const mixinsLabBusyDelay = Duration(seconds: 2);

/// Bag of functions. Not a Flutter type. Not a second parent.
///
/// `runBusy`: busy on, do the work, busy off.
/// Each State that `with MixinsLabBusyMixin` gets its own `busy`.
mixin MixinsLabBusyMixin<T extends StatefulWidget> on State<T> {
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
