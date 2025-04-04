import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/borrowers/screens/borrowers_screen/borrower_list_tile.dart';
import 'package:libertad/features/borrowers/viewmodels/borrowers_list_viewmodel.dart';

/// Page with all the borrowers in the database displayed in a list view.
class BorrowersPage extends ConsumerWidget {
  const BorrowersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve borrowers data and actively watch for changes.
    final AsyncValue<List<Borrower>> borrowers =
        ref.watch(borrowersListViewModelProvider);

    // Check for error and loading states and build the widget accordingly.
    return borrowers.when(
        data: (data) => ListView.separated(
              padding: const EdgeInsets.only(bottom: 64),
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const Divider(height: 0),
              itemBuilder: (context, index) {
                return BorrowerListTile(borrower: data[index], index: index);
              },
            ),
        error: (error, stackTrace) =>
            Center(child: Text('An unexpected error has occured.')),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
