import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoneet_test/src/constants/colors.dart';
import 'package:memoneet_test/src/utils/app_button.dart';
import 'package:memoneet_test/src/utils/app_snack_bar.dart';
import 'package:memoneet_test/src/utils/app_text_field.dart';

import '../../../models/note_model.dart';
import '../home_page_model.dart';

@RoutePage()
class AddNotePage extends ConsumerStatefulWidget {
  const AddNotePage({super.key});

  @override
  ConsumerState<AddNotePage> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends ConsumerState<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool titleError = false;
  bool desError = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(homePageModelProvider.select((value) => value.addNoteStatus),
        (previous, next) {
      if (next != previous) {
        if (next == AddNoteStatus.loaded) {
          context.router.pop();
          ref.read(homePageModelProvider.notifier).fetchAllNotes();
          return;
        }
        if (next == AddNoteStatus.error) {
          AppSnackBar.showErrorMessage(
              context,
              ref.read(homePageModelProvider.select((value) =>
                  value.addNoteErrorMessage ?? 'Error adding Note')));
        }
      }
    });
    final status =
        ref.watch(homePageModelProvider.select((value) => value.addNoteStatus));
    return Stack(
      children: [
        IgnorePointer(
          ignoring: status == AddNoteStatus.loading,
          child: Opacity(
            opacity: status == AddNoteStatus.loading ? 0.5 : 1.0,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Add Note'),
                backgroundColor: AppColors.primaryColor,
              ),
              body: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Note Title',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AppTextField(
                        hint: 'Enter title',
                        controller: _titleController,
                        errorText: titleError ? 'Title cannot be empty' : null,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              titleError = false;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Note Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AppTextField(
                        hint: 'Enter description',
                        maxLines: 4,
                        controller: _contentController,
                        errorText:
                            desError ? 'Description cannot be empty' : null,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              desError = false;
                            });
                          }
                        },
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 30,
                        ),
                        child: AppButton(
                          text: 'Add',
                          isProcessing: ref.read(homePageModelProvider
                                  .select((value) => value.addNoteStatus)) ==
                              AddNoteStatus.loading,
                          buttonColor: AppColors.primaryColor,
                          onClicked: () {
                            if (_titleController.text.isEmpty) {
                              setState(() {
                                titleError = true;
                              });
                              return;
                            }
                            if (_contentController.text.isEmpty) {
                              setState(() {
                                desError = true;
                              });
                              return;
                            }
                            ref.read(homePageModelProvider.notifier).addNote(
                                  NoteModel(
                                    title: _titleController.text,
                                    content: _contentController.text,
                                    date: DateTime.now(),
                                  ),
                                );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (status == AddNoteStatus.loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
