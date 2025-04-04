// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrower_details_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$borrowerDetailsViewModelHash() =>
    r'9786768d7848e3052ef2b68350f4d842776d8ec9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BorrowerDetailsViewModel
    extends BuildlessAutoDisposeNotifier<Borrower> {
  late final Borrower borrower;

  Borrower build(
    Borrower borrower,
  );
}

/// Business logic layer for borrower details page.
///
/// Copied from [BorrowerDetailsViewModel].
@ProviderFor(BorrowerDetailsViewModel)
const borrowerDetailsViewModelProvider = BorrowerDetailsViewModelFamily();

/// Business logic layer for borrower details page.
///
/// Copied from [BorrowerDetailsViewModel].
class BorrowerDetailsViewModelFamily extends Family<Borrower> {
  /// Business logic layer for borrower details page.
  ///
  /// Copied from [BorrowerDetailsViewModel].
  const BorrowerDetailsViewModelFamily();

  /// Business logic layer for borrower details page.
  ///
  /// Copied from [BorrowerDetailsViewModel].
  BorrowerDetailsViewModelProvider call(
    Borrower borrower,
  ) {
    return BorrowerDetailsViewModelProvider(
      borrower,
    );
  }

  @override
  BorrowerDetailsViewModelProvider getProviderOverride(
    covariant BorrowerDetailsViewModelProvider provider,
  ) {
    return call(
      provider.borrower,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'borrowerDetailsViewModelProvider';
}

/// Business logic layer for borrower details page.
///
/// Copied from [BorrowerDetailsViewModel].
class BorrowerDetailsViewModelProvider extends AutoDisposeNotifierProviderImpl<
    BorrowerDetailsViewModel, Borrower> {
  /// Business logic layer for borrower details page.
  ///
  /// Copied from [BorrowerDetailsViewModel].
  BorrowerDetailsViewModelProvider(
    Borrower borrower,
  ) : this._internal(
          () => BorrowerDetailsViewModel()..borrower = borrower,
          from: borrowerDetailsViewModelProvider,
          name: r'borrowerDetailsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$borrowerDetailsViewModelHash,
          dependencies: BorrowerDetailsViewModelFamily._dependencies,
          allTransitiveDependencies:
              BorrowerDetailsViewModelFamily._allTransitiveDependencies,
          borrower: borrower,
        );

  BorrowerDetailsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.borrower,
  }) : super.internal();

  final Borrower borrower;

  @override
  Borrower runNotifierBuild(
    covariant BorrowerDetailsViewModel notifier,
  ) {
    return notifier.build(
      borrower,
    );
  }

  @override
  Override overrideWith(BorrowerDetailsViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: BorrowerDetailsViewModelProvider._internal(
        () => create()..borrower = borrower,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        borrower: borrower,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<BorrowerDetailsViewModel, Borrower>
      createElement() {
    return _BorrowerDetailsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BorrowerDetailsViewModelProvider &&
        other.borrower == borrower;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, borrower.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BorrowerDetailsViewModelRef on AutoDisposeNotifierProviderRef<Borrower> {
  /// The parameter `borrower` of this provider.
  Borrower get borrower;
}

class _BorrowerDetailsViewModelProviderElement
    extends AutoDisposeNotifierProviderElement<BorrowerDetailsViewModel,
        Borrower> with BorrowerDetailsViewModelRef {
  _BorrowerDetailsViewModelProviderElement(super.provider);

  @override
  Borrower get borrower =>
      (origin as BorrowerDetailsViewModelProvider).borrower;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
