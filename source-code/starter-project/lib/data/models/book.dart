import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/genre.dart';

/// Represents book collection in the database.
class Book {
  /// Book's title.
  String title;

  /// Book's author.
  Author? author;

  /// Book's genre.
  Genre genre;

  /// Book's release date.
  DateTime releaseDate;

  /// Book's summary.
  String summary;

  /// Path to book's cover image in the app's directory.
  String coverImage;

  /// Set of all the copies of the book.

  final Set<BookCopy> totalCopies = {};

  /// Date/time of object creation.
  late final DateTime createdAt;

  /// Date/time of object updation.
  late DateTime updatedAt;

  /// Set of issued copies.
  Set<BookCopy> get issuedCopies =>
      totalCopies.where((copy) => copy.isIssued).toSet();

  Book({
    required this.title,
    required this.genre,
    required this.releaseDate,
    required this.summary,
    this.coverImage = '',
  });

  /// Creates a copy of the object with the provided parameters.
  Book copyWith({
    String? title,
    Genre? genre,
    DateTime? releaseDate,
    String? summary,
    String? coverImage,
  }) =>
      Book(
        title: title ?? this.title,
        genre: genre ?? this.genre,
        releaseDate: releaseDate ?? this.releaseDate,
        summary: summary ?? this.summary,
        coverImage: coverImage ?? this.coverImage,
      );
}
