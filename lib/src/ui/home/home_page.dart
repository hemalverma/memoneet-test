import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotexh_test/src/constants/colors.dart';
import 'package:infotexh_test/src/logic/repo/app_repository.dart';
import 'package:infotexh_test/src/routing/app_router.dart';
import 'package:infotexh_test/src/ui/home/graphql_api_data/api_data_widget.dart';
import 'package:infotexh_test/src/ui/home/home_page_model.dart';
import 'package:infotexh_test/src/utils/text_style.dart';

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
      ref.read(homePageModelProvider.notifier).fetchAllUsers();
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
        ref.watch(homePageModelProvider.select((value) => value.users));
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${userData?.name ?? 'User'}'),
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
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          context.router.push(const EditProfileRoute());
                        },
                        child: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Name : ${userData.name ?? 'Name'}'),
                  Text('Email : ${userData.email ?? 'Email'}'),
                  Text('Phone : ${userData.phone ?? 'Phone'}'),
                  Text('Password : ${userData.password ?? 'Password'}'),
                ],
              ),
            ),
          if (data != null)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Registered Users',
                        style: AppTextStyles.headline6,
                      ),
                    ],
                  ),
                  ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(
                        child: Text((index + 1).toString()),
                      ),
                      title: Text(data[index].name ?? 'Name'),
                      subtitle: Text(data[index].email ?? 'Email'),
                      trailing: userData?.id == data[index].id
                          ? Text(
                              'LoggedIn',
                              style: AppTextStyles.success,
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          const Expanded(
            child: ApiDataWidget(),
          ),
        ],
      ),
    );
  }
}
