// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static m0(length) => "Das Passwort muss mindestens ${length} Zeichen lang sein.";

  static m1(length) => "Dein Nutzername muss mindestens ${length} Zeichen lang sein.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "btn_getStarted" : MessageLookupByLibrary.simpleMessage("Loslegen"),
    "btn_register" : MessageLookupByLibrary.simpleMessage("Registrieren"),
    "btn_signIn" : MessageLookupByLibrary.simpleMessage("Anmelden"),
    "errorEmptyRequiredField" : MessageLookupByLibrary.simpleMessage("Dieses Feld darf nicht leer sein."),
    "errorGeneralApiError" : MessageLookupByLibrary.simpleMessage("Etwas ist schiefgelaufen. Bitte versuche es erneut."),
    "errorInvalidEmail" : MessageLookupByLibrary.simpleMessage("Bitte trage eine gültige E-Mail ein."),
    "errorMinPasswordLength" : m0,
    "errorMinUsernameLength" : m1,
    "errorPasswordMatch" : MessageLookupByLibrary.simpleMessage("Passwörter stimmen nicht überein."),
    "errorSignIn" : MessageLookupByLibrary.simpleMessage("E-Mail oder Passwort stimmen nicht überein. Bitte versuche es erneut."),
    "navigationBarHome" : MessageLookupByLibrary.simpleMessage("Home"),
    "navigationChat" : MessageLookupByLibrary.simpleMessage("Chat"),
    "navigationCommunities" : MessageLookupByLibrary.simpleMessage("Communities"),
    "navigationSettings" : MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "registerConfirmEmailHint" : MessageLookupByLibrary.simpleMessage("Bestätige deine E-Mail, um die Registrierung abzuschließen."),
    "registerEmail" : MessageLookupByLibrary.simpleMessage("E-Mail"),
    "registerPassword" : MessageLookupByLibrary.simpleMessage("Passwort"),
    "registerPasswordRepeat" : MessageLookupByLibrary.simpleMessage("Passwort wiederholen"),
    "registerSignInHere1" : MessageLookupByLibrary.simpleMessage("Du hast bereits einen Account?"),
    "registerSignInHere2" : MessageLookupByLibrary.simpleMessage("Hier anmelden"),
    "registerUsername" : MessageLookupByLibrary.simpleMessage("Username"),
    "registerUsernameHint" : MessageLookupByLibrary.simpleMessage("Du kannst auch später einen Usernamen festlegen."),
    "signInForgotPassword" : MessageLookupByLibrary.simpleMessage("Passwort vergessen?"),
    "signInPassword" : MessageLookupByLibrary.simpleMessage("Passswort"),
    "signInRegisterHere1" : MessageLookupByLibrary.simpleMessage("Noch nicht angemeldet?"),
    "signInRegisterHere2" : MessageLookupByLibrary.simpleMessage("Hier registrieren"),
    "signInUsernameOrEmail" : MessageLookupByLibrary.simpleMessage("E-Mail"),
    "welcomeDescription" : MessageLookupByLibrary.simpleMessage("Willkommen in der Community, wo Meinungsfreiheit und respektvolle Interaktionen im Mittelpunkt stehen. Starte deine Reise mit uns und finde deinen Platz in einer vielfältigen, anonymen und inspirierenden Umgebung – DIVER erwartet dich!"),
    "welcomeHeadline" : MessageLookupByLibrary.simpleMessage("Deine Stimme, deine Anonymität, deine Community.")
  };
}
