import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:libertad/data/mock/mock_data.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/author_sort.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/book_filters.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/borrower_filters.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/image_folder.dart';
import 'package:libertad/data/models/issued_copy_filters.dart';
import 'package:libertad/data/models/issued_copy_sort.dart';
import 'package:libertad/data/models/search_result.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';

import 'files_repository.dart';

/// Repository of methods that mocks a database.
class MockDatabaseRepository extends DatabaseRepository {
  MockDatabaseRepository();

  /// Stores books data in memory.
  List<Book> books = [];

  /// Stores authors data in memory.
  List<Author> authors = [];

  /// Stores borrowers data in memory.
  List<Borrower> borrowers = [];

  @override
  Future<void> initialize() async {
    _initializeBooks();
    _initializeAuthors();
    _initializeBorrowers();
  }

  /// Populates [books] with mock books data.
  /// Adds author and creation/updation data-time to each model as well.
  void _initializeBooks() {
    // Copy the mock books data.
    final List<Book> mockBooksData =
        MockData.books.map((book) => book.copyWith()).toList();
    // Add missing fields to the book object.
    for (final Book book in mockBooksData) {
      final index = mockBooksData.indexOf(book);
      // Add author.
      book.author = MockData.authors[index];
      // Add creation and updation data/time.
      book
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();
    }
    books = mockBooksData;
  }

  /// Populates [authors] with mock authors data.
  /// Adds books and creation/updation data-time to each model as well.
  void _initializeAuthors() {
    // Copy the mock Authors data.
    final List<Author> mockAuthorsData =
        MockData.authors.map((author) => author.copyWith()).toList();
    // Add missing fields to the author object.
    for (final Author author in mockAuthorsData) {
      final index = mockAuthorsData.indexOf(author);
      // Add book.
      author.books.add(MockData.books[index]);
      // Add creation and updation data/time.
      author
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();
    }
    authors = mockAuthorsData;
  }

  /// Populates [borrowers] with mock borrowers data.
  /// Adds creation/updation data-time to each model as well.
  void _initializeBorrowers() {
    // Copy the mock Borrowers data.
    final List<Borrower> mockBorrowersData =
        MockData.borrowers.map((borrower) => borrower.copyWith()).toList();
    // Add missing fields to the borrower object.
    for (final Borrower borrower in mockBorrowersData) {
      // Add creation and updation data/time.
      borrower
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();
    }

    borrowers = mockBorrowersData;
  }

  @override
  Future<void> initializeForTest() async => throw UnimplementedError();

  // BEGIN: WATCHERS

  @override
  Stream<void> get booksStream => throw UnimplementedError();

  @override
  Stream<void> bookStream(Id id) => throw UnimplementedError();

  @override
  Stream<void> get authorsStream => throw UnimplementedError();

  @override
  Stream<void> authorStream(Id id) => throw UnimplementedError();

  @override
  Stream<void> get bookCopiesStream => throw UnimplementedError();

  @override
  Stream<void> bookCopyStream(Id id) => throw UnimplementedError();

  @override
  Stream<void> get borrowersStream => throw UnimplementedError();

  @override
  Stream<void> borrowerStream(Id id) => throw UnimplementedError();

  // END: WATCHERS

  // BEGIN: DATA FETCHERS

  @override
  Future<Book?> getBook(Id id) async => throw UnimplementedError();

  @override
  Future<Author?> getAuthor(Id id) async => throw UnimplementedError();

  @override
  Future<BookCopy?> getBookCopy(Id id) async => throw UnimplementedError();

  @override
  Future<Borrower?> getBorrower(Id id) async => throw UnimplementedError();

  @override
  Future<List<Book>> getBooks({
    BookSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    BookFilters filters = const BookFilters(),
  }) async =>
      books;

  @override
  Future<List<Author>> getAuthors({
    AuthorSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
  }) async =>
      authors;

  @override
  Future<List<BookCopy>> getIssuedCopies({
    IssuedCopySort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    IssuedCopyFilters filters = const IssuedCopyFilters(),
  }) async =>
      [];

  @override
  Future<List<BookCopy>> getAllCopies() async => throw UnimplementedError();

  @override
  Future<List<Borrower>> getBorrowers({
    BorrowerSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    BorrowerFilters filters = const BorrowerFilters(),
  }) async =>
      borrowers;

  // END: DATA FETCHERS

  // BEGIN: CREATION

  @override
  Future<void> addBook(Book book, Author author, int totalCopies) async =>
      log('Book "${book.title}" added!');

  @override
  Future<void> addBorrower(Borrower borrower) async =>
      log('Borrower "${borrower.name}" added!');

  // END: CREATION

  // BEGIN: UPDATION

  @override
  Future<void> updateBook(
          Book book, Author newAuthor, int newTotalCopies) async =>
      log('Book "${book.title}" updated!');

  @override
  Future<void> updateAuthor(Author author) async =>
      log('Author "${author.name}" updated!');

  @override
  Future<void> updateBorrower(Borrower borrower) async =>
      log('Borrower "${borrower.name}" updated!');

  // END: UPDATION

  // BEGIN: DELETION

  @override
  Future<bool> deleteBook(Book book) async {
    log('Book "${book.title}" deleted!');
    return true;
  }

  @override
  Future<bool> deleteAuthor(Author author) async {
    log('Author "${author.name}" deleted!');
    return true;
  }

  @override
  Future<bool> deleteBorrower(Borrower borrower) async {
    log('Borrower "${borrower.name}" deleted!');
    return true;
  }

  // END: DELETION

  // BEGIN: LIBRARY TRANSACTIONS

  @override
  Future<void> issueCopy(BookCopy copy, Borrower borrower) async =>
      throw UnimplementedError();

  @override
  Future<void> returnCopy(BookCopy copy, Borrower borrower) async =>
      throw UnimplementedError();

  @override
  Future<void> acceptFine(Borrower borrower) async =>
      throw UnimplementedError();

  // END: LIBRARY TRANSACTIONS

  // BEGIN: SEARCH

  @override
  Future<List<Author>> searchAuthors(String name) async => authors;

  @override
  Future<List<Borrower>> searchBorrowers(String name,
          {bool active = false}) async =>
      borrowers;

  @override
  Future<SearchResult> searchDatabase(String query) async => SearchResult(
      books: books, authors: authors, issuedCopies: [], borrowers: borrowers);

  // END: SEARCH

  // BEGIN: DEVELOPER OPTIONS

  @override
  Future<void> clearDatabase() async => initialize();

  @override
  Future<void> resetDatabase({deleteImages = true}) async {
    if (deleteImages) {
      await FilesRepository.instance.deleteImageFolder(ImageFolder.bookCovers);
      await FilesRepository.instance
          .deleteImageFolder(ImageFolder.authorProfilePictures);
      await FilesRepository.instance
          .deleteImageFolder(ImageFolder.borrowerProfilePictures);
    }
    return initialize();
  }

  // END: DEVELOPER OPTIONS
}
