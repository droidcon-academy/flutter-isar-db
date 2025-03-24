// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrowers_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$borrowersListViewModelHash() =>
    r'e2e8ffd8aac07ea17ea127ed0541a274dedf970b';

/// Business logic layer for borrowers list page.
///
/// Copied from [BorrowersListViewModel].
@ProviderFor(BorrowersListViewModel)
final borrowersListViewModelProvider = AutoDisposeAsyncNotifierProvider<
    BorrowersListViewModel, List<Borrower>>.internal(
  BorrowersListViewModel.new,
  name: r'borrowersListViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$borrowersListViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BorrowersListViewModel = AutoDisposeAsyncNotifier<List<Borrower>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
