import 'package:diver/constants.dart';
import 'package:diver/utils/utils.dart';
import 'package:diver/widgets/buttons/primary_button.dart';
import 'package:diver/widgets/text_fields/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diver/generated/l10n.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FormGroup _formGroup = fb.group({
    'emailOrUsername': ['', Validators.required],
    'password': ['', Validators.required]
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Diver",
                style: GoogleFonts.yesevaOne(
                    fontSize:
                        Theme.of(context).textTheme.displayMedium?.fontSize),
              ),
              const SizedBox(height: 32),
              ReactiveForm(
                formGroup: _formGroup,
                child: Column(
                  children: [
                    ReactiveTextField(
                      formControlName: 'emailOrUsername',
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: themeBasedBorderSide(context)),
                        labelText: S.of(context).signInUsernameOrEmail,
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(height: 24),
                    ReactiveTextField(
                      formControlName: "password",
                      decoration: InputDecoration(
                        labelText: S.of(context).signInPassword,
                        border: OutlineInputBorder(
                            borderSide: themeBasedBorderSide(context)),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          S.of(context).signInForgotPassword,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w100,
                                color: themeBasedDimmedContentColor(context),
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ReactiveFormConsumer(builder: (context, form, child) {
                      return PrimaryButton(
                        text: S.of(context).btn_signIn,
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/feed');
                        },
                        disabled: form.invalid,
                      );
                    }),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed('/register'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).signInRegisterHere1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color:
                                        themeBasedDimmedContentColor(context)),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            S.of(context).signInRegisterHere2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: themeBasedDimmedContentColor(context),
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
    );
  }
}
