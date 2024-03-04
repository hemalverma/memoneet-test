import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infotexh_test/src/logic/repo/app_repository.dart';
import 'package:infotexh_test/src/ui/auth/edit_profile/edit_profile_page_model.dart';
import 'package:infotexh_test/src/ui/home/home_page_model.dart';
import 'package:infotexh_test/src/utils/app_button.dart';
import 'package:infotexh_test/src/utils/app_snack_bar.dart';
import 'package:infotexh_test/src/utils/app_text_field.dart';
import 'package:infotexh_test/src/utils/text_style.dart';

import '../../../constants/colors.dart';

@RoutePage()
class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<EditProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(editProfilePageModelProvider.notifier).fetchMyProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(editProfilePageModelProvider.select((value) => value.saveStatus),
        (previous, next) {
      if (next != previous) {
        if (next == SaveStatus.loaded) {
          ref.read(appRepositoryProvider.notifier).updateData();
          ref.read(homePageModelProvider.notifier).fetchAllUsers();
          context.router.pop();
          AppSnackBar.showSuccessMessage(context, 'Profile updated');
        }
        if (next == SaveStatus.error) {
          AppSnackBar.showErrorMessage(
              context,
              ref.read(editProfilePageModelProvider
                  .select((value) => value.errorMessage ?? 'Error Occurred')));
        }
      }
    });

    final fetchStatus = ref.watch(
        editProfilePageModelProvider.select((value) => value.fetchStatus));

    final saveStatus = ref.watch(
        editProfilePageModelProvider.select((value) => value.saveStatus));

    final nameError = ref
        .watch(editProfilePageModelProvider.select((value) => value.nameError));
    final emailError = ref.watch(
        editProfilePageModelProvider.select((value) => value.emailError));
    final phoneError = ref.watch(
        editProfilePageModelProvider.select((value) => value.phoneError));
    final passwordError = ref.watch(
        editProfilePageModelProvider.select((value) => value.passwordError));

    final name =
        ref.watch(editProfilePageModelProvider.select((value) => value.name));
    final email =
        ref.watch(editProfilePageModelProvider.select((value) => value.email));
    final phone =
        ref.watch(editProfilePageModelProvider.select((value) => value.phone));
    final password = ref
        .watch(editProfilePageModelProvider.select((value) => value.password));

    if (name != null) {
      nameController.text = name;
    }
    if (email != null) {
      emailController.text = email;
    }
    if (phone != null) {
      phoneController.text = phone;
    }
    if (password != null) {
      passwordController.text = password;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
            'My Profile',
            style: AppTextStyles.title,
          ),
          backgroundColor: AppColors.primaryColor),
      body: fetchStatus == FetchStatus.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 10,
                            ),
                            child: Text(
                              'You can Edit the Profile',
                              style: AppTextStyles.title,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Text(
                            'Please override the details to update',
                            style: AppTextStyles.body,
                          ),
                        ),
                        AppTextField(
                          hint: 'Enter your name',
                          controller: nameController,
                          errorText: nameError && saveStatus == SaveStatus.error
                              ? ref.read(editProfilePageModelProvider
                                  .select((value) => value.errorMessage))
                              : null,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              ref
                                  .read(editProfilePageModelProvider.notifier)
                                  .setNameError(false);
                            }
                            ref
                                .read(editProfilePageModelProvider.notifier)
                                .setName(val);
                          },
                        ),
                        AppTextField(
                          hint: 'Enter your email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          errorText:
                              emailError && saveStatus == SaveStatus.error
                                  ? ref.read(editProfilePageModelProvider
                                      .select((value) => value.errorMessage))
                                  : null,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              ref
                                  .read(editProfilePageModelProvider.notifier)
                                  .setEmailError(false);
                            }
                            ref
                                .read(editProfilePageModelProvider.notifier)
                                .setEmail(val);
                          },
                        ),
                        AppTextField(
                          hint: 'Enter your phone number',
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          errorText:
                              phoneError && saveStatus == SaveStatus.error
                                  ? ref.read(editProfilePageModelProvider
                                      .select((value) => value.errorMessage))
                                  : null,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              ref
                                  .read(editProfilePageModelProvider.notifier)
                                  .setPhoneError(false);
                            }
                            ref
                                .read(editProfilePageModelProvider.notifier)
                                .setPhone(val);
                          },
                        ),
                        AppTextField(
                          hint: 'Choose your Password',
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          errorText:
                              passwordError && saveStatus == SaveStatus.error
                                  ? ref.read(editProfilePageModelProvider
                                      .select((value) => value.errorMessage))
                                  : null,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              ref
                                  .read(editProfilePageModelProvider.notifier)
                                  .setPasswordError(false);
                            }
                            ref
                                .read(editProfilePageModelProvider.notifier)
                                .setPassword(val);
                          },
                        ),
                      ],
                    ),
                  ),
                  AppButton(
                    text: 'Save',
                    isProcessing: ref.watch(editProfilePageModelProvider
                            .select((value) => value.saveStatus)) ==
                        SaveStatus.loading,
                    buttonColor: AppColors.primaryColor,
                    onClicked: () {
                      ref
                          .read(editProfilePageModelProvider.notifier)
                          .validateAndRegister();
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
    );
  }
}
