// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(length) => "The password has to be at least ${length} characters long.";

  static m1(length) => "The username has to be at least ${length} characters long.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "btn_getStarted" : MessageLookupByLibrary.simpleMessage("Get started"),
    "btn_post" : MessageLookupByLibrary.simpleMessage("Post"),
    "btn_register" : MessageLookupByLibrary.simpleMessage("Register"),
    "btn_signIn" : MessageLookupByLibrary.simpleMessage("Sign in"),
    "errorEmptyRequiredField" : MessageLookupByLibrary.simpleMessage("This field must not be empty."),
    "errorGeneralApiError" : MessageLookupByLibrary.simpleMessage("Something went wrong. Please try again."),
    "errorInvalidEmail" : MessageLookupByLibrary.simpleMessage("Please fill in a valid email."),
    "errorMinPasswordLength" : m0,
    "errorMinUsernameLength" : m1,
    "errorPasswordMatch" : MessageLookupByLibrary.simpleMessage("Passwords don\'t match."),
    "errorSignIn" : MessageLookupByLibrary.simpleMessage("Email or password didn\'t match. Please try again."),
    "navigationBarHome" : MessageLookupByLibrary.simpleMessage("Home"),
    "navigationChat" : MessageLookupByLibrary.simpleMessage("Chat"),
    "navigationCommunities" : MessageLookupByLibrary.simpleMessage("Communities"),
    "navigationSettings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "newPostEnterSomething" : MessageLookupByLibrary.simpleMessage("Enter something to be able to post."),
    "newPostHintText" : MessageLookupByLibrary.simpleMessage("Write something..."),
    "registerConfirmEmailHint" : MessageLookupByLibrary.simpleMessage("Confirm your e-mail to complete the registration."),
    "registerEmail" : MessageLookupByLibrary.simpleMessage("Email"),
    "registerPassword" : MessageLookupByLibrary.simpleMessage("Password"),
    "registerPasswordRepeat" : MessageLookupByLibrary.simpleMessage("Repeat password"),
    "registerSignInHere1" : MessageLookupByLibrary.simpleMessage("Have an account?"),
    "registerSignInHere2" : MessageLookupByLibrary.simpleMessage("Sign in here"),
    "registerUsername" : MessageLookupByLibrary.simpleMessage("Username"),
    "registerUsernameHint" : MessageLookupByLibrary.simpleMessage("You can also create a username at a later time."),
    "signInForgotPassword" : MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "signInPassword" : MessageLookupByLibrary.simpleMessage("Passsword"),
    "signInRegisterHere1" : MessageLookupByLibrary.simpleMessage("No account yet?"),
    "signInRegisterHere2" : MessageLookupByLibrary.simpleMessage("Register here"),
    "signInUsernameOrEmail" : MessageLookupByLibrary.simpleMessage("Email"),
    "welcomeDescription" : MessageLookupByLibrary.simpleMessage("Welcome to the community where freedom of expression and respectful interactions take center stage. Begin your journey with us and find your place in a diverse, anonymous, and inspiring environment – DIVER awaits you!"),
    "welcomeHeadline" : MessageLookupByLibrary.simpleMessage("Your voice, your anonymity, your community.")
  };
}
