import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/issue_status.dart';

/// Represents book copy collection in the database.
class BookCopy {
  /// Copy's book.
  Book? book;

  /// Date when the copy is issued.
  DateTime? issueDate;

  /// Date when the copy is due to return.
  DateTime? returnDate;

  /// Current borrower of the copy.
  Borrower? currentBorrower;

  /// Previous borrowers of the copy.
  final Set<Borrower> previousBorrowers = {};

  /// Defines whether the copy is currently issued or available.
  IssueStatus status = IssueStatus.available;

  /// Whether the copy is issued.
  bool get isIssued => status.isIssued;

  /// Whether the copy is available.
  bool get isAvailable => status.isAvailable;

  /// Whether the copy's return date has passed.
  bool get returnDatePassed => returnDate?.isBefore(DateTime.now()) ?? false;

  /// Returns the number of days by which the issued copy has surpassed the
  /// return date.
  int overdueBy() {
    if (returnDatePassed) {
      return DateTime.now().difference(returnDate!).inDays;
    } else {
      return 0;
    }
  }

  /// Creates a copy of the object.
  BookCopy copyWith() => BookCopy();
}
