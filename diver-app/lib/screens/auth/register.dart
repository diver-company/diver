import 'package:diver/constants.dart';
import 'package:diver/utils/utils.dart';
import 'package:diver/widgets/buttons/primary_button.dart';
import 'package:diver/widgets/text_fields/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diver/generated/l10n.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FormGroup _form = fb.group({
    'email': ['', Validators.required, Validators.email],
    'password': ['', Validators.required],
    'confirmPassword': ['', Validators.required],
    'username': ['']
  }, [
    Validators.mustMatch('password', 'confirmPassword')
  ]);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Diver",
                    style: GoogleFonts.yesevaOne(
                        fontSize: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.fontSize),
                  ),
                  const SizedBox(height: 32),
                  ReactiveForm(
                    formGroup: _form,
                    child: Column(
                      children: [
                        ReactiveTextField(
                          obscureText: false,
                          formControlName: 'email',
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).registerEmail),
                        ),
                        const SizedBox(height: 24),
                        ReactiveTextField(
                          obscureText: true,
                          formControlName: 'password',
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).registerPassword),
                        ),
                        const SizedBox(height: 24),
                        ReactiveTextField(
                          obscureText: true,
                          formControlName: 'confirmPassword',
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).registerPasswordRepeat),
                        ),
                        const SizedBox(height: 64),
                        ReactiveTextField(
                          obscureText: false,
                          formControlName: 'username',
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).registerUsername),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).registerUsernameHint,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color:
                                        themeBasedDimmedContentColor(context),
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        ReactiveFormConsumer(
                          builder: (context, form, child) {
                            return PrimaryButton(
                              text: S.of(context).btn_register,
                              onTap: () {},
                              disabled: form.invalid,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).registerSignInHere1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.w100,
                                        color: themeBasedDimmedContentColor(
                                            context)),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                S.of(context).registerSignInHere2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          themeBasedDimmedContentColor(context),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
