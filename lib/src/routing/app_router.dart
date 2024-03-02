import 'package:auto_route/auto_route.dart';
import 'package:infotexh_test/src/ui/auth/register/register_page.dart';

import '../ui/auth/edit_profile/edit_profile_page.dart';
import '../ui/auth/login/login_page.dart';
import '../ui/home/home_page.dart';
import '../ui/onboarding/splash_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          page: SplashRoute.page,
          path: '/splash',
          initial: true,
        ),
        AutoRoute(
          page: RegisterRoute.page,
          path: '/register',
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
        ),
        AutoRoute(
          page: EditProfileRoute.page,
          path: '/edit-profile',
        ),
      ];
}
