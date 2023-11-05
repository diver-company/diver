import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:diver/constants.dart';
import 'package:diver/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diver/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<void> _completeWelcomeScreen(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(kHasSeenWelcomeScreen, true);

    if (context.mounted) {
      AutoRouter.of(context).pushNamed('/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.fontSize,
                                color: kContentColorDarkTheme),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            S.of(context).welcomeHeadline,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: kContentColorDarkTheme,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            S.of(context).welcomeDescription,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      height: 1.5,
                                      color: kContentColorDarkTheme,
                                    ),
                          ),
                          const SizedBox(height: 24.0),
                          PrimaryButton(
                            text: S.of(context).btn_getStarted,
                            icon: Icons.arrow_forward_rounded,
                            onTap: () => _completeWelcomeScreen(context),
                          ),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
