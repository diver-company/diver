import 'package:diver/constants.dart';
import 'package:diver/utils/utils.dart';
import 'package:diver/widgets/buttons/primary_button.dart';
import 'package:diver/widgets/text_fields/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Form(
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Username or Email",
                    obscureText: false,
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    hintText: "Password",
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password?",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w100,
                              color: themeBasedContentColor(context),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    text: "Sign in",
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed('/register'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No account yet?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: themeBasedContentColor(context)),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Register here",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
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
    );
  }
}
