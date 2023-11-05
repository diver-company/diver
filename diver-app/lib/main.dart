import 'package:diver/constants.dart';
import 'package:diver/core/supabase/supabase.dart';
import 'package:diver/env.dart';
import 'package:diver/theme.dart';
import 'package:diver/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:diver/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);

  runApp(const Diver());
}

class Diver extends StatefulWidget {
  const Diver({super.key});

  @override
  State<Diver> createState() => _DiverState();
}

class _DiverState extends State<Diver> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();

    _decideInitialNavigation();
  }

  Future<void> _decideInitialNavigation() async {
    if (isAuthenticated()) {
      _appRouter.replaceNamed('/app/feed');
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final bool? hasSeenWelcomeScreen = prefs.getBool(kHasSeenWelcomeScreen);

      if (hasSeenWelcomeScreen != null && hasSeenWelcomeScreen) {
        _appRouter.replaceNamed('/sign-in');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
      routerConfig: _appRouter.config(),
      /*initialRoute: _isNew ? '/' : '/sign-in',
      routes: {
        '/': (context) => const Welcome(),
        '/sign-in': (context) => const SignIn(),
        '/register': (context) => const Register(),
        '/feed': (context) => const App(),
        '/feed/new-post': (context) => const NewPost(),
      },*/
    );
  }
}
