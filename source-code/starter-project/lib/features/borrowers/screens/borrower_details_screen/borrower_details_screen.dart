import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copy_tile.dart';
import 'package:libertad/features/borrowers/viewmodels/borrower_details_viewmodel.dart';
import 'package:libertad/widgets/profile_picture.dart';

/// Page with borrower's details such as their name, profile picture, and the
/// books borrowed by them.
class BorrowerDetailsPage extends ConsumerWidget {
  final Borrower borrower;

  const BorrowerDetailsPage({super.key, required this.borrower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for changes to update the UI with the latest data.
    ref.watch(borrowerDetailsViewModelProvider(borrower));
    final BorrowerDetailsViewModel model =
        ref.watch(borrowerDetailsViewModelProvider(borrower).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrower Details'),
        actions: [
          if (!borrower.isActive) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: Center(
                child: Text(
                  'INACTIVE',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Edit',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
                onTap: () => model.showBorrowerEditor(context),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Delete',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ],
                ),
                onTap: () => model.showDeletionDialog(context),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxWidth: kSmallPhone + 48),
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: kSmallPhone / 2),
                    width: MediaQuery.of(context).size.width / 2,
                    child: ProfilePicture(
                      imageFilePath: model.borrower.profilePicture,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    model.borrower.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    prettifyContact(borrower.contact),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 16),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.labelLarge,
                      children: [
                        TextSpan(text: 'Member from '),
                        TextSpan(
                          text: borrower.membershipStartDate.prettifyDate,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).primaryColor,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                        TextSpan(text: ' to '),
                        TextSpan(
                          text: borrower.membershipEndDate.prettifyDate,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).primaryColor,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (borrower.isDefaulter) ...[
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color:
                                  Theme.of(context).colorScheme.errorContainer),
                          child: Center(
                            child: Text(
                              'DEFAULTER',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.labelLarge,
                            children: [
                              TextSpan(text: 'Fine Due: '),
                              TextSpan(
                                text: '\$${borrower.fineDue.toInt()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                  Divider(height: 48),
                  if (borrower.currentlyIssuedBooks.isNotEmpty) ...[
                    Column(
                      children: [
                        Text(
                          'Issued Books',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        ...List.generate(
                          borrower.currentlyIssuedBooks.length,
                          (index) {
                            final BookCopy copy =
                                borrower.currentlyIssuedBooks.toList()[index];
                            return IssuedCopyTile(
                              copy: copy,
                              index: index,
                              minimal: true,
                            );
                          },
                        ),
                      ],
                    ),
                    Divider(height: 48),
                  ],
                  if (borrower.previouslyIssuedBooks.isNotEmpty) ...[
                    Column(
                      children: [
                        Text(
                          'Previously Issued',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        ...List.generate(
                          borrower.previouslyIssuedBooks.length,
                          (index) {
                            final BookCopy copy =
                                borrower.previouslyIssuedBooks.toList()[index];
                            return IssuedCopyTile(
                              copy: copy,
                              index: index,
                              minimal: true,
                            );
                          },
                        ),
                      ],
                    ),
                    Divider(height: 48),
                  ],
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Created: ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: borrower.createdAt.prettifyDateAndTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Updated: ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: borrower.updatedAt.prettifyDateAndTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: borrower.isDefaulter
          ? FloatingActionButton.extended(
              onPressed: () => model.showFineDialog(context, borrower),
              icon: Icon(
                Icons.monetization_on_rounded,
                size: 20,
              ),
              label: Text(
                'Accept Fine',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
            )
          : null,
    );
  }

  /// Formats the contact number to interanational format: (+1 XXX-XXX-XXXX).
  String prettifyContact(String contact) {
    return '+1 ${contact.substring(0, 3)}-${contact.substring(3, 6)}-${contact.substring(6)}';
  }
}
