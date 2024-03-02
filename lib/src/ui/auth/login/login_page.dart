import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotexh_test/src/logic/repo/app_repository.dart';
import 'package:infotexh_test/src/routing/app_router.dart';
import 'package:infotexh_test/src/ui/auth/login/login_page_model.dart';
import 'package:infotexh_test/src/utils/app_button.dart';
import 'package:infotexh_test/src/utils/app_snack_bar.dart';
import 'package:infotexh_test/src/utils/app_text_field.dart';
import 'package:infotexh_test/src/utils/text_style.dart';

import '../../../constants/colors.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<LoginPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(appRepositoryProvider.select((value) => value.appStatus),
        (previous, next) {
      if (next != previous) {
        if (next == AppState.authenticated) {
          context.router.replace(const HomeRoute());
        }
      }
    });
    ref.listen(loginPageModelProvider.select((value) => value.loginStatus),
        (previous, next) {
      if (next != previous) {
        if (next == LoginStatus.loginFailed) {
          AppSnackBar.showErrorMessage(
              context,
              ref.read(loginPageModelProvider
                  .select((value) => value.errorMessage ?? 'Error Occurred')));
        }
      }
    });

    final status =
        ref.watch(loginPageModelProvider.select((value) => value.loginStatus));
    final emailError =
        ref.watch(loginPageModelProvider.select((value) => value.emailError));
    final passwordError = ref
        .watch(loginPageModelProvider.select((value) => value.passwordError));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
            'Login',
            style: AppTextStyles.title,
          ),
          backgroundColor: AppColors.primaryColor),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 150,
                      alignment: Alignment.center,
                      child: Text(
                        'Welcome to Our App',
                        style: AppTextStyles.title,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Please login to continue',
                      style: AppTextStyles.body,
                    ),
                  ),
                  AppTextField(
                    hint: 'Enter your email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    errorText: emailError && status == LoginStatus.loginFailed
                        ? ref.read(loginPageModelProvider
                            .select((value) => value.errorMessage))
                        : null,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        ref
                            .read(loginPageModelProvider.notifier)
                            .setEmailError(false);
                      }
                      ref.read(loginPageModelProvider.notifier).setEmail(val);
                    },
                  ),
                  AppTextField(
                    hint: 'Enter your Password',
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    errorText:
                        passwordError && status == LoginStatus.loginFailed
                            ? ref.read(loginPageModelProvider
                                .select((value) => value.errorMessage))
                            : null,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        ref
                            .read(loginPageModelProvider.notifier)
                            .setPasswordError(false);
                      }
                      ref
                          .read(loginPageModelProvider.notifier)
                          .setPassword(val);
                    },
                  ),
                ],
              ),
            ),
            AppButton(
              text: 'Login',
              isProcessing: ref.watch(loginPageModelProvider
                      .select((value) => value.loginStatus)) ==
                  LoginStatus.logging,
              buttonColor: AppColors.primaryColor,
              onClicked: () {
                ref.read(loginPageModelProvider.notifier).validateAndLogin();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 30,
              ),
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.router.replace(const RegisterRoute());
                  },
                  child: Text(
                    'Don\'t have an account? Signup',
                    style: AppTextStyles.body,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
