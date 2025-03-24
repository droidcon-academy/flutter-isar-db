// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authors_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authorsListViewModelHash() =>
    r'c5fa2f8bbbd8f089ee730af22e68b100cad27590';

/// Business logic layer for authors list page.
///
/// Copied from [AuthorsListViewModel].
@ProviderFor(AuthorsListViewModel)
final authorsListViewModelProvider = AutoDisposeAsyncNotifierProvider<
    AuthorsListViewModel, List<Author>>.internal(
  AuthorsListViewModel.new,
  name: r'authorsListViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authorsListViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthorsListViewModel = AutoDisposeAsyncNotifier<List<Author>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
