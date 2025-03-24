// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$booksListViewModelHash() =>
    r'567828b09308eacd53eea344155e16b013713e06';

/// Business logic layer for books list page.
///
/// Copied from [BooksListViewModel].
@ProviderFor(BooksListViewModel)
final booksListViewModelProvider =
    AutoDisposeAsyncNotifierProvider<BooksListViewModel, List<Book>>.internal(
  BooksListViewModel.new,
  name: r'booksListViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$booksListViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BooksListViewModel = AutoDisposeAsyncNotifier<List<Book>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
