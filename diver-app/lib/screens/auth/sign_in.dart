import 'package:auto_route/auto_route.dart';
import 'package:diver/constants.dart';
import 'package:diver/core/supabase/supabase.dart';
import 'package:diver/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diver/generated/l10n.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _hasSupabaseError = false;
  bool _hasGeneralError = false;
  bool _submitted = false;
  bool _passwordObscured = true;

  final FormGroup _formGroup = fb.group({
    'email': ['', Validators.required, Validators.email],
    'password': ['', Validators.required]
  });

  Future<void> _login(BuildContext context) async {
    setState(() {
      _submitted = true;
      _hasGeneralError = false;
      _hasSupabaseError = false;
    });

    try {
      final formValue = _formGroup.value;

      await supabase.auth.signInWithPassword(
          password: formValue['password'].toString(),
          email: formValue['email'].toString());

      if (context.mounted) {
        setState(() {
          _submitted = false;
        });
        AutoRouter.of(context).replaceNamed('/app/feed');
      }
    } on AuthException {
      setState(() {
        _submitted = false;
        _hasSupabaseError = true;
      });
    } catch (e) {
      setState(() {
        _submitted = false;
        _hasGeneralError = true;
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
                  if (_hasSupabaseError) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            S.of(context).errorSignIn,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  ReactiveForm(
                    formGroup: _formGroup,
                    child: Column(
                      children: [
                        ReactiveTextField(
                          formControlName: 'email',
                          keyboardType: TextInputType.emailAddress,
                          validationMessages: {
                            ValidationMessage.email: (error) =>
                                S.of(context).errorInvalidEmail,
                            ValidationMessage.required: (error) =>
                                S.of(context).errorEmptyRequiredField
                          },
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
                          validationMessages: {
                            ValidationMessage.required: (error) =>
                                S.of(context).errorEmptyRequiredField
                          },
                          decoration: InputDecoration(
                              labelText: S.of(context).signInPassword,
                              border: OutlineInputBorder(
                                  borderSide: themeBasedBorderSide(context)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordObscured = !_passwordObscured;
                                    });
                                  },
                                  icon: _passwordObscured
                                      ? const Icon(Icons.visibility_rounded)
                                      : const Icon(
                                          Icons.visibility_off_rounded))),
                          obscureText: _passwordObscured,
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
                                    : () => _login(context),
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
                                      S.of(context).btn_signIn,
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
                          onTap: () =>
                              AutoRouter.of(context).pushNamed('/register'),
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
                                        color: themeBasedDimmedContentColor(
                                            context)),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                S.of(context).signInRegisterHere2,
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
