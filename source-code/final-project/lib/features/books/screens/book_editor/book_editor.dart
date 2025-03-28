import 'package:flutter/material.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/features/books/screens/book_editor/book_add_update_button.dart';
import 'package:libertad/features/books/screens/book_editor/genre_field.dart';
import 'package:libertad/features/books/screens/book_editor/release_date_field.dart';
import 'package:libertad/features/books/screens/book_editor/total_copies_field.dart';
import 'package:libertad/widgets/row_column_switch.dart';

import 'author_field.dart';
import 'editable_book_cover.dart';
import 'summary_field.dart';
import 'title_field.dart';

/// Allows the user to add a new book or edit an existing one.
class BookEditor extends StatelessWidget {
  final Book? book;

  const BookEditor({super.key, this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.80,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double maxWidth = constraints.maxWidth;
                    // Whether to build a column or a row. Depends on screen
                    // size.
                    final bool buildColumn = maxWidth < kSmallPhone / 3;
                    // Gap between book cover and text fields.
                    final double gap = 16;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RowColumnSwitch(
                          columnWhen: buildColumn,
                          crossAxisAlignment: buildColumn
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width:
                                  buildColumn ? (maxWidth / 2) : (maxWidth / 3),
                              child: EditableBookCover(book: book),
                            ),
                            SizedBox(
                              width: buildColumn ? null : gap,
                              height: buildColumn ? gap : null,
                            ),
                            SizedBox(
                              width: buildColumn
                                  ? maxWidth
                                  : (maxWidth / 1.5 - gap),
                              child: Column(
                                children: [
                                  TitleField(book: book),
                                  SizedBox(height: 16),
                                  AuthorField(book: book),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 32),
                        SummaryField(book: book),
                        SizedBox(height: 32),
                        RowColumnSwitch(
                          columnWhen: buildColumn,
                          crossAxisAlignment: buildColumn
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:
                                  buildColumn ? maxWidth : (maxWidth - gap) / 2,
                              child: GenreField(book: book),
                            ),
                            SizedBox(
                              width: buildColumn ? null : gap,
                              height: buildColumn ? gap : null,
                            ),
                            SizedBox(
                              width:
                                  buildColumn ? maxWidth : (maxWidth - gap) / 2,
                              child: ReleaseDateField(book: book),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TotalCopiesField(book: book),
                        SizedBox(height: 32),
                        Center(
                          child: BookAddUpdateButton(book: book),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
