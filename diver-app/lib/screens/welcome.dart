import 'dart:ui';

import 'package:diver/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
                duration: const Duration(milliseconds: 500),
                builder: (BuildContext context, double opacity, Widget? child) {
                  return Opacity(
                    opacity: opacity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Diver",
                          style: GoogleFonts.yesevaOne(
                              fontSize: 64.0,
                              textStyle: const TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(height: 8),
                        Text("Deine Stimme, deine Anonymität, deine Community.",
                            style: GoogleFonts.inter(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w200,
                                textStyle: const TextStyle(color: Colors.white))),
                        const SizedBox(height: 8.0),
                        Text(
                            "Willkommen in der Community, wo Meinungsfreiheit und respektvolle Interaktionen im Mittelpunkt stehen. Starte deine Reise mit uns und finde deinen Platz in einer vielfältigen, anonymen und inspirierenden Umgebung – DIVER erwartet dich!",
                            style: GoogleFonts.inter(
                                fontSize: 12.0,
                                textStyle: const TextStyle(color: Colors.white))),
                        const SizedBox(height: 24.0),
                        PrimaryButton(
                          text: "Loslegen",
                          icon: Icons.arrow_forward_rounded,
                          onTap: () {},
                        ),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  );
                },
              )
            ),
          ),
        )
      ],
    ));
  }
}
