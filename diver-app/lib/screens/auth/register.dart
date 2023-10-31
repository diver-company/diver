import 'package:diver/constants.dart';
import 'package:diver/utils/utils.dart';
import 'package:diver/widgets/buttons/primary_button.dart';
import 'package:diver/widgets/text_fields/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diver/generated/l10n.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

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
                  Form(
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: S.of(context).registerEmail,
                          obscureText: false,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 24),
                        CustomTextField(
                          hintText: S.of(context).registerPassword,
                          obscureText: true,
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 24),
                        CustomTextField(
                          hintText: S.of(context).registerPasswordRepeat,
                          obscureText: true,
                          controller: _repeatPasswordController,
                        ),
                        const SizedBox(height: 64),
                        CustomTextField(
                          hintText: S.of(context).registerUsername,
                          obscureText: false,
                          controller: _usernameController,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).registerUsernameHint,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w100,
                                color: themeBasedContentColor(context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        PrimaryButton(
                          text: S.of(context).btn_register,
                          onTap: () {},
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
                                        color: themeBasedContentColor(context)),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                S.of(context).registerSignInHere2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: themeBasedContentColor(context),
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
