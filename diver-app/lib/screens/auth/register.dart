import 'package:auto_route/auto_route.dart';
import 'package:diver/constants.dart';
import 'package:diver/core/supabase/supabase.dart';
import 'package:diver/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diver/generated/l10n.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _hasGeneralError = false;
  bool _submitted = false;

  final FormGroup _form = fb.group({
    'email': ['', Validators.required, Validators.email],
    'password': ['', Validators.required, Validators.minLength(6)],
    'confirmPassword': ['', Validators.required, Validators.minLength(6)],
    'username': ['']
  }, [
    Validators.mustMatch('password', 'confirmPassword', markAsDirty: false)
  ]);

  Future<void> _register(BuildContext context) async {
    setState(() {
      _submitted = true;
      _hasGeneralError = false;
    });

    try {
      final formValue = _form.value;

      await supabase.auth.signUp(
          password: formValue['password'].toString(),
          email: formValue['email'].toString());

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16.0),
              content: Text(S.of(context).registerConfirmEmailHint),
            )
        );
        AutoRouter.of(context).pushNamed('/sign-in');
      }
    } catch (e) {
      setState(() {
        _hasGeneralError = true;
      });
    } finally {
      setState(() {
        _submitted = false;
      });
    }
  }

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
                  if (_hasGeneralError) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).errorGeneralApiError,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.error),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  ReactiveForm(
                    formGroup: _form,
                    child: Column(
                      children: [
                        ReactiveTextField(
                          obscureText: false,
                          formControlName: 'email',
                          validationMessages: {
                            ValidationMessage.email: (error) => S.of(context).errorInvalidEmail,
                            ValidationMessage.required: (error) => S.of(context).errorEmptyRequiredField
                          },
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).registerEmail),
                        ),
                        const SizedBox(height: 24),
                        ReactiveTextField(
                          obscureText: true,
                          formControlName: 'password',
                          validationMessages: {
                            ValidationMessage.required: (error) => S.of(context).errorEmptyRequiredField,
                            ValidationMessage.minLength: (error) => S.of(context).errorMinPasswordLength(6)
                          },
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).registerPassword),
                        ),
                        const SizedBox(height: 24),
                        ReactiveTextField(
                          obscureText: true,
                          formControlName: 'confirmPassword',
                          validationMessages: {
                            ValidationMessage.required: (error) => S.of(context).errorEmptyRequiredField,
                            ValidationMessage.minLength: (error) => S.of(context).errorMinPasswordLength(6),
                            'mustMatch': (error) => S.of(context).errorPasswordMatch
                          },
                          showErrors: (control) => control.invalid && control.touched && control.dirty,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).registerPasswordRepeat),
                        ),
                        const SizedBox(height: 64),
                        ReactiveTextField(
                          obscureText: false,
                          formControlName: 'username',
                          validationMessages: {
                            ValidationMessage.minLength: (error) => S.of(context).errorMinUsernameLength(4)
                          },
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
                            return SizedBox(
                              width: double.infinity,
                              height: 56.0,
                              child: FilledButton(
                                onPressed: form.invalid || _submitted
                                    ? null
                                    : () => _register(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (_submitted) ...[
                                      const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                    Text(
                                      S.of(context).btn_register,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () => AutoRouter.of(context).back(),
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
