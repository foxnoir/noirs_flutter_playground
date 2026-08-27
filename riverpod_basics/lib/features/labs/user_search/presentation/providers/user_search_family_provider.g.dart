// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_family_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userSearchFamily)
final userSearchFamilyProvider = UserSearchFamilyFamily._();

final class UserSearchFamilyProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<User>>,
          List<User>,
          FutureOr<List<User>>
        >
    with $FutureModifier<List<User>>, $FutureProvider<List<User>> {
  UserSearchFamilyProvider._({
    required UserSearchFamilyFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userSearchFamilyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userSearchFamilyHash();

  @override
  String toString() {
    return r'userSearchFamilyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<User>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<User>> create(Ref ref) {
    final argument = this.argument as String;
    return userSearchFamily(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSearchFamilyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSearchFamilyHash() => r'76f40d837d89108d767f4948a89476d418d6f03c';

final class UserSearchFamilyFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<User>>, String> {
  UserSearchFamilyFamily._()
    : super(
        retry: null,
        name: r'userSearchFamilyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserSearchFamilyProvider call(String query) =>
      UserSearchFamilyProvider._(argument: query, from: this);

  @override
  String toString() => r'userSearchFamilyProvider';
}
