import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotexh_test/src/logic/repo/app_repository.dart';

import '../../routing/app_router.dart';

@RoutePage()
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appRepositoryProvider, (previous, next) {
      if (next.appStatus == AppState.authenticated) {
        context.router.replace(const HomeRoute());
      } else if (next.appStatus == AppState.unauthenticated) {
        context.router.replace(const LoginRoute());
      } else {
        context.router.replace(const LoginRoute());
      }
    });
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text('loading...'),
        ],
      ),
    );
  }
}
