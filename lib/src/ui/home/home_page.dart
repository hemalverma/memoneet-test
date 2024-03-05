import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memoneet_test/src/constants/colors.dart';
import 'package:memoneet_test/src/logic/repo/app_repository.dart';
import 'package:memoneet_test/src/routing/app_router.dart';
import 'package:memoneet_test/src/ui/home/home_page_model.dart';
import 'package:memoneet_test/src/utils/text_style.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(homePageModelProvider.notifier).fetchAllNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(appRepositoryProvider.select((value) => value.appStatus),
        (previous, next) {
      if (next != previous) {
        if (next == AppState.unauthenticated) {
          context.router.replace(const LoginRoute());
        }
      }
    });
    final userData =
        ref.watch(appRepositoryProvider.select((value) => value.userModel));
    final data =
        ref.watch(homePageModelProvider.select((value) => value.notes));
    final status =
        ref.watch(homePageModelProvider.select((value) => value.status));

    final deleteStatus = ref
        .watch(homePageModelProvider.select((value) => value.deleteNoteStatus));

    return Stack(
      children: [
        IgnorePointer(
          ignoring: deleteStatus == DeleteNoteStatus.loading,
          child: Opacity(
            opacity: deleteStatus == DeleteNoteStatus.loading ? 0.5 : 1.0,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Welcome ${userData?.email ?? 'User'}'),
                backgroundColor: AppColors.primaryColor,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      ref.read(appRepositoryProvider.notifier).logout();
                    },
                  ),
                ],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (userData != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 10,
                        left: 10,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My Profile',
                                style: AppTextStyles.headline6,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          //Text('Name : ${userData.name ?? 'Name'}'),
                          Text('Email : ${userData.email ?? 'Email'}'),
                          Text(
                              'Password : ${userData.password ?? '*********'}'),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      'Notes',
                      style: AppTextStyles.headline6,
                    ),
                  ),
                  Expanded(
                    child: status == HomeStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : status == HomeStatus.error
                            ? Text(ref.read(homePageModelProvider.select(
                                (value) => value.errorMessage ?? 'Error')))
                            : data == null
                                ? const Text('No Notes Data')
                                : ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      final note = data[index];
                                      return ListTile(
                                        leading: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        title: Text(note.title),
                                        subtitle: Text(
                                          note.content,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                context.router.push(
                                                  EditNoteRoute(
                                                    noteModel: note,
                                                  ),
                                                );
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                ref
                                                    .read(homePageModelProvider
                                                        .notifier)
                                                    .deleteNote(note);
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.router.push(const AddNoteRoute());
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ),
        if (deleteStatus == DeleteNoteStatus.loading)
          const Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Deleting Note...',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          )
      ],
    );
  }
}
