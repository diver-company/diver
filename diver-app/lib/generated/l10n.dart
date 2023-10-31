// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Your voice, your anonymity, your community.`
  String get welcomeHeadline {
    return Intl.message(
      'Your voice, your anonymity, your community.',
      name: 'welcomeHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the community where freedom of expression and respectful interactions take center stage. Begin your journey with us and find your place in a diverse, anonymous, and inspiring environment – DIVER awaits you!`
  String get welcomeDescription {
    return Intl.message(
      'Welcome to the community where freedom of expression and respectful interactions take center stage. Begin your journey with us and find your place in a diverse, anonymous, and inspiring environment – DIVER awaits you!',
      name: 'welcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Username or Email`
  String get signInUsernameOrEmail {
    return Intl.message(
      'Username or Email',
      name: 'signInUsernameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Passsword`
  String get signInPassword {
    return Intl.message(
      'Passsword',
      name: 'signInPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get signInForgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'signInForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `No account yet?`
  String get signInRegisterHere1 {
    return Intl.message(
      'No account yet?',
      name: 'signInRegisterHere1',
      desc: '',
      args: [],
    );
  }

  /// `Register here`
  String get signInRegisterHere2 {
    return Intl.message(
      'Register here',
      name: 'signInRegisterHere2',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get registerEmail {
    return Intl.message(
      'Email',
      name: 'registerEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get registerPassword {
    return Intl.message(
      'Password',
      name: 'registerPassword',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get registerPasswordRepeat {
    return Intl.message(
      'Repeat password',
      name: 'registerPasswordRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get registerUsername {
    return Intl.message(
      'Username',
      name: 'registerUsername',
      desc: '',
      args: [],
    );
  }

  /// `You can also create a username at a later time.`
  String get registerUsernameHint {
    return Intl.message(
      'You can also create a username at a later time.',
      name: 'registerUsernameHint',
      desc: '',
      args: [],
    );
  }

  /// `Have an account?`
  String get registerSignInHere1 {
    return Intl.message(
      'Have an account?',
      name: 'registerSignInHere1',
      desc: '',
      args: [],
    );
  }

  /// `Sign in here`
  String get registerSignInHere2 {
    return Intl.message(
      'Sign in here',
      name: 'registerSignInHere2',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get btn_getStarted {
    return Intl.message(
      'Get started',
      name: 'btn_getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get btn_signIn {
    return Intl.message(
      'Sign in',
      name: 'btn_signIn',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get btn_register {
    return Intl.message(
      'Register',
      name: 'btn_register',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}