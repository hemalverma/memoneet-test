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
class EditNotePage extends ConsumerStatefulWidget {
  const EditNotePage({super.key, required this.noteModel});
  final NoteModel noteModel;

  @override
  ConsumerState<EditNotePage> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends ConsumerState<EditNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool titleError = false;
  bool desError = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.noteModel.title;
    _contentController.text = widget.noteModel.content;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(homePageModelProvider.select((value) => value.updateNoteStatus),
        (previous, next) {
      if (next != previous) {
        if (next == UpdateNoteStatus.loaded) {
          context.router.pop();
          ref.read(homePageModelProvider.notifier).fetchAllNotes();
          return;
        }
        if (next == UpdateNoteStatus.error) {
          AppSnackBar.showErrorMessage(
              context,
              ref.read(homePageModelProvider.select((value) =>
                  value.addNoteErrorMessage ?? 'Error updating Note')));
        }
      }
    });
    final status = ref
        .watch(homePageModelProvider.select((value) => value.updateNoteStatus));
    return Stack(
      children: [
        IgnorePointer(
          ignoring: status == UpdateNoteStatus.loading,
          child: Opacity(
            opacity: status == UpdateNoteStatus.loading ? 0.5 : 1.0,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Update Note'),
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
                          text: 'Update Note',
                          isProcessing: ref.read(homePageModelProvider
                                  .select((value) => value.updateNoteStatus)) ==
                              UpdateNoteStatus.loading,
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
                            ref.read(homePageModelProvider.notifier).updateNote(
                                  NoteModel(
                                    id: widget.noteModel.id,
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
        if (status == UpdateNoteStatus.loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
