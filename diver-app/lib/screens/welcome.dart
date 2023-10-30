import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:diver/constants.dart';
import 'package:diver/widgets/primary_button.dart';
import 'package:diver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diver/generated/l10n.dart';

enum Sex { male, female, diverse }

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final TextEditingController _usernameController = TextEditingController();
  final SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;

  bool _showWelcomeScreen = true;
  Sex selectedSex = Sex.male;

  void _toggleShowWelcomeScreen() {
    setState(() {
      _showWelcomeScreen = !_showWelcomeScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
          reverse: !_showWelcomeScreen,
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: _transitionType,
              child: child,
            );
          },
          child: _showWelcomeScreen ? _welcomeScreen() : _onboarding()),
    );
  }

  Widget _onboarding() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _toggleShowWelcomeScreen,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Geschlecht",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton(
                showSelectedIcon: false,
                segments: const <ButtonSegment<Sex>>[
                  ButtonSegment<Sex>(
                    value: Sex.male,
                    label: Text("Männlich"),
                  ),
                  ButtonSegment<Sex>(
                    value: Sex.female,
                    label: Text("Weiblich"),
                  ),
                  ButtonSegment<Sex>(
                    value: Sex.diverse,
                    label: Text("Divers"),
                  )
                ],
                selected: <Sex>{selectedSex},
                onSelectionChanged: (Set<Sex> newSelection) {
                  setState(() {
                    selectedSex = newSelection.first;
                  });
                },
              ),
            ),
            Expanded(flex: 1, child: Container()),
            PrimaryButton(
              text: "Continue",
              onTap: () {},
            )
          ],
        ),
      )),
    );
  }

  Widget _welcomeScreen() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset("assets/img/splashscreen.jpg", fit: BoxFit.cover),
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  curve: Curves.bounceInOut,
                  duration: const Duration(milliseconds: 250),
                  builder:
                      (BuildContext context, double opacity, Widget? child) {
                    return Opacity(
                      opacity: opacity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Diver",
                            style: GoogleFonts.yesevaOne(
                                fontSize: 64.0, color: kContentColorDarkTheme),
                          ),
                          const SizedBox(height: 8),
                          Text(S.of(context).welcomeHeadline,
                              style: GoogleFonts.inter(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w200,
                                  color: kContentColorDarkTheme)),
                          const SizedBox(height: 8.0),
                          Text(
                            S.of(context).welcomeDescription,
                            style: GoogleFonts.inter(
                                fontSize: 12.0,
                                color: kContentColorDarkTheme,
                                height: 1.5),
                          ),
                          const SizedBox(height: 24.0),
                          PrimaryButton(
                            text: S.of(context).btn_getStarted,
                            icon: Icons.arrow_forward_rounded,
                            onTap: _toggleShowWelcomeScreen,
                          ),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                    );
                  },
                )),
          ),
        ),
      ],
    );
  }
}
