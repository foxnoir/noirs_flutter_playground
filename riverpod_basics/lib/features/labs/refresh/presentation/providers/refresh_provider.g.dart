// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 400ms so the spinner is visible. Tests set this to [Duration.zero].

@ProviderFor(refreshPingDelay)
final refreshPingDelayProvider = RefreshPingDelayProvider._();

/// 400ms so the spinner is visible. Tests set this to [Duration.zero].

final class RefreshPingDelayProvider
    extends $FunctionalProvider<Duration, Duration, Duration>
    with $Provider<Duration> {
  /// 400ms so the spinner is visible. Tests set this to [Duration.zero].
  RefreshPingDelayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'refreshPingDelayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$refreshPingDelayHash();

  @$internal
  @override
  $ProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration create(Ref ref) {
    return refreshPingDelay(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }
}

String _$refreshPingDelayHash() => r'bb68d998b24fb5bf6f66df5f6989ff21ffa29e08';

/// How many times the fake GET has *started*. Keep-alive so a refresh of
/// [refreshPingProvider] does not reset the count to 1.

@ProviderFor(refreshPingCount)
final refreshPingCountProvider = RefreshPingCountProvider._();

/// How many times the fake GET has *started*. Keep-alive so a refresh of
/// [refreshPingProvider] does not reset the count to 1.

final class RefreshPingCountProvider
    extends
        $FunctionalProvider<
          RefreshPingCounter,
          RefreshPingCounter,
          RefreshPingCounter
        >
    with $Provider<RefreshPingCounter> {
  /// How many times the fake GET has *started*. Keep-alive so a refresh of
  /// [refreshPingProvider] does not reset the count to 1.
  RefreshPingCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'refreshPingCountProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$refreshPingCountHash();

  @$internal
  @override
  $ProviderElement<RefreshPingCounter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RefreshPingCounter create(Ref ref) {
    return refreshPingCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RefreshPingCounter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RefreshPingCounter>(value),
    );
  }
}

String _$refreshPingCountHash() => r'4d51435281e0ce5e990c3e9639daaf355c6c6639';

/// Fake GET /ping. `ref.refresh(refreshPingProvider)` / `invalidate`
/// run **this function** again. You name the provider, not `.next()`.

@ProviderFor(refreshPing)
final refreshPingProvider = RefreshPingProvider._();

/// Fake GET /ping. `ref.refresh(refreshPingProvider)` / `invalidate`
/// run **this function** again. You name the provider, not `.next()`.

final class RefreshPingProvider
    extends
        $FunctionalProvider<
          AsyncValue<RefreshPing>,
          RefreshPing,
          FutureOr<RefreshPing>
        >
    with $FutureModifier<RefreshPing>, $FutureProvider<RefreshPing> {
  /// Fake GET /ping. `ref.refresh(refreshPingProvider)` / `invalidate`
  /// run **this function** again. You name the provider, not `.next()`.
  RefreshPingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'refreshPingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$refreshPingHash();

  @$internal
  @override
  $FutureProviderElement<RefreshPing> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RefreshPing> create(Ref ref) {
    return refreshPing(ref);
  }
}

String _$refreshPingHash() => r'6e382a607a00ee73e90a6e800b292cf89bc88e47';
