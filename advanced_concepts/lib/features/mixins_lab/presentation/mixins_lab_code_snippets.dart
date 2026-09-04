/// Exact Dart shown in the lab (not localized).
abstract final class MixinsLabCodeSnippets {
  static const illegal =
      'class _MixinsLabSaveButtonState\n'
      '    extends State<MixinsLabSaveButton>, OtherClass';

  static const withMixin =
      'class _MixinsLabSaveButtonState\n'
      '    extends State<MixinsLabSaveButton>\n'
      '    with MixinsLabBusyMixin\n'
      '\n'
      'class _MixinsLabReloadCardState\n'
      '    extends State<MixinsLabReloadCard>\n'
      '    with MixinsLabBusyMixin';

  static const mixinSource =
      'mixin MixinsLabBusyMixin on State {\n'
      '  var busy = false;\n'
      '\n'
      '  // busy on → do work → busy off\n'
      '  Future<void> runBusy(work) async {\n'
      '    busy = true;\n'
      '    await work();\n'
      '    busy = false;\n'
      '  }\n'
      '}';
}
