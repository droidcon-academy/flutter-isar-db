import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:libertad/data/mock/mock_data.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/borrower_field.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/return_date_field.dart';
import 'package:libertad/features/books/screens/book_details_screen/copy_list_tile.dart';
import 'package:libertad/main.dart' as app;
import 'package:libertad/widgets/book_list_tile.dart';

/// Checks whether app has already been launched before the test is run.
/// If the app has already been launched, it means that the Isar instance is
/// active and shouldn't be initialized again. In this case, we manually run the
/// app without initializing the database.
/// If the app hasn't been launched, we run the [main] method which initializes
/// the database internally before running the app.
bool _appLaunched = false;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Tests issue book flow.
  testWidgets('Issue book flow', (tester) async {
    // Launch app.
    await launchApp(tester);
    // Reset database.
    await resetDatabase(tester);
    // Navigate to book details page.
    await navigateToBookDetailsPage(tester);
    // Navigate to copy details page.
    await navigateToCopyDetailsPage(tester);
    // Issue copy.
    await issueCopy(tester);

    // Expect the copy to be issued to the borrower.
    expect(find.text('issued to'), findsAny);
  });

  /// Tests issuance details edit flow.
  testWidgets('Issuance details edit flow', (tester) async {
    // Launch app.
    await launchApp(tester);
    // Reset database.
    await resetDatabase(tester);
    // Navigate to book details page.
    await navigateToBookDetailsPage(tester);
    // Navigate to copy details page.
    await navigateToCopyDetailsPage(tester);
    // Issue copy.
    await issueCopy(tester);

    // Get the list of active borrowers from mock borrowers data.
    final List<Borrower> activeBorrowers =
        MockData.borrowers.where((borrower) => borrower.isActive).toList();
    // Get the first borrower. It's the one whom we have issued the book.
    final Borrower firstBorrower = activeBorrowers[0];

    // Expect the copy to be issued to the first borrower.
    expect(find.text(firstBorrower.name), findsAny);

    // Open popup menu.
    await tester.tap(find.byTooltip('Show menu'));
    await tester.pumpAndSettle();
    // Tap on edit button.
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    // Select a new borrower.
    await tester.tap(find.byType(BorrowerField));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ListTile).at(2));
    await tester.pumpAndSettle();
    // Tap on save edits button.
    await tester.tap(find.text('Save Edits'));
    await tester.pumpAndSettle();

    // Get the third borrower. We have now issued the copy to the third
    // borrower.
    final Borrower thirdBorrower = activeBorrowers[2];

    // Expect the copy to be issued to the third borrower.
    expect(find.text(thirdBorrower.name), findsAny);
  });

  /// Tests return book flow.
  testWidgets('Return book flow', (tester) async {
    // Launch app.
    await launchApp(tester);
    // Reset database.
    await resetDatabase(tester);
    // Navigate to book details page.
    await navigateToBookDetailsPage(tester);
    // Navigate to copy details page.
    await navigateToCopyDetailsPage(tester);
    // Issue copy.
    await issueCopy(tester);

    // Expect the copy to be issued to the borrower.
    expect(find.text('issued to'), findsAny);

    // Tap on return button.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    // Tap on return copy button.
    await tester.tap(find.byType(TextButton).last);
    await tester.pumpAndSettle();

    // Expect the copy to be marked as returned and available.
    expect(find.text('AVAILABLE'), findsAny);
  });
}

/// Launches the app via [main] method or manually pumps the [Libertad] widget
/// which is the entry point of the application.
Future<void> launchApp(WidgetTester tester) async {
  if (_appLaunched) {
    // If app has already been launched, pump the [Libertad] widget manually.
    // [ProviderScope] is essential for riverpod models to inegrate with the UI.
    await tester.pumpWidget(const ProviderScope(child: app.Libertad()));
  } else {
    // Else, launch the app by calling the [main] method. This will initialize
    // the database as well.
    await app.main();
  }
  // Mark the app as launched.
  _appLaunched = true;
  await tester.pumpAndSettle();
}

/// Resets the database to its original state with mock data.
Future<void> resetDatabase(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Show menu'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Reset database'));
  await tester.pumpAndSettle();
}

/// Navigates to book details page from books list tab.
Future<void> navigateToBookDetailsPage(WidgetTester tester) async {
  await tester.tap(find.byType(BookListTile).at(0));
  await tester.pumpAndSettle();
}

/// Navigates to copy details page from book details page.
Future<void> navigateToCopyDetailsPage(WidgetTester tester) async {
  await tester.scrollUntilVisible(find.byType(CopyListTile).at(0), 50);
  await tester.tap(find.byType(CopyListTile).at(0));
  await tester.pumpAndSettle();
}

/// Issues copy by selecting a return date and a borrower.
Future<void> issueCopy(WidgetTester tester) async {
  // Tap on issue button.
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
  // Fill in the return date.
  await tester.tap(find.byType(ReturnDateField));
  await tester.pumpAndSettle();
  await tester.tap(find.text('30'));
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
  // Select borrower.
  await tester.tap(find.byType(BorrowerField));
  await tester.pumpAndSettle();
  await tester.tap(find.byType(ListTile).at(0));
  await tester.pumpAndSettle();
  // Tap on issue copy button.
  await tester.tap(find.byType(TextButton));
  await tester.pumpAndSettle();
}
