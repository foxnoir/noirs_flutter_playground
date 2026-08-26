// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_by_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserById)
final userByIdProvider = UserByIdFamily._();

final class UserByIdProvider extends $AsyncNotifierProvider<UserById, User> {
  UserByIdProvider._({
    required UserByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'userByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userByIdHash();

  @override
  String toString() {
    return r'userByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserById create() => UserById();

  @override
  bool operator ==(Object other) {
    return other is UserByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userByIdHash() => r'0934d3f0ee1bcc0fbb1e298889dc804465283a89';

final class UserByIdFamily extends $Family
    with
        $ClassFamilyOverride<
          UserById,
          AsyncValue<User>,
          User,
          FutureOr<User>,
          int
        > {
  UserByIdFamily._()
    : super(
        retry: null,
        name: r'userByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserByIdProvider call(int id) => UserByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'userByIdProvider';
}

abstract class _$UserById extends $AsyncNotifier<User> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<User> build(int id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User>, User>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User>, User>,
              AsyncValue<User>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
