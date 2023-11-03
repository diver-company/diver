import 'package:auto_route/auto_route.dart';
import 'package:diver/core/routing/app_router.dart';
import 'package:diver/core/supabase/supabase.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (supabase.auth.currentSession != null && !supabase.auth.currentSession!.isExpired) {
      resolver.next(true);
    } else {
      resolver.redirect(const SignInRoute());
    }
  }
}