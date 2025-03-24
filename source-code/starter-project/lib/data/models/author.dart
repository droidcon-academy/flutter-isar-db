import 'package:libertad/data/models/book.dart';

/// Represents author collection in the database.
class Author {
  /// Author's name.
  String name;

  /// Author's bio.
  String bio;

  /// Path to the author's profile picture in the app's directory.
  String profilePicture;

  /// Books written by the author.
  final Set<Book> books = {};

  /// Date/time of object creation.
  late final DateTime createdAt;

  /// Date/time of object updation.
  late DateTime updatedAt;

  Author({
    required this.name,
    required this.bio,
    this.profilePicture = '',
  });

  /// Creates a copy of the object with the provided parameters.
  Author copyWith({
    String? name,
    String? bio,
    String? profilePicture,
  }) =>
      Author(
        name: name ?? this.name,
        bio: bio ?? this.bio,
        profilePicture: profilePicture ?? this.profilePicture,
      );
}
