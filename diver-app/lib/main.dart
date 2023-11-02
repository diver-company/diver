import 'package:diver/constants.dart';
import 'package:diver/screens/app/app.dart';
import 'package:diver/screens/auth/register.dart';
import 'package:diver/screens/auth/sign_in.dart';
import 'package:diver/screens/posts/new_post.dart';
import 'package:diver/screens/welcome.dart';
import 'package:diver/theme.dart';
import 'package:flutter/material.dart';
import 'package:diver/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Diver());
}

class Diver extends StatefulWidget {
  const Diver({super.key});

  @override
  State<Diver> createState() => _DiverState();
}

class _DiverState extends State<Diver> {
  bool _isNew = true;

  @override
  void initState() {
    super.initState();

    _decideInitialNavigation();
  }

  Future<void> _decideInitialNavigation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? hasSeenWelcomeScreen = prefs.getBool(kHasSeenWelcomeScreen);

    if (hasSeenWelcomeScreen != null && hasSeenWelcomeScreen) {
      setState(() {
        _isNew = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: customThemeData(context, isDark: false),
      darkTheme: customThemeData(context, isDark: true),
      title: "DIVER",
      initialRoute: _isNew ? '/' : '/sign-in',
      routes: {
        '/': (context) => const Welcome(),
        '/sign-in': (context) => const SignIn(),
        '/register': (context) => const Register(),
        '/feed': (context) => const App(),
        '/feed/new-post': (context) => const NewPost(),
      },
    );
  }
}
