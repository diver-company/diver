import 'package:auto_route/auto_route.dart';
import 'package:diver/core/guards/auth.guard.dart';
import 'package:diver/screens/app/app.dart';
import 'package:diver/screens/auth/register.dart';
import 'package:diver/screens/auth/sign_in.dart';
import 'package:diver/screens/chat/chat.dart';
import 'package:diver/screens/feed/feed.dart';
import 'package:diver/screens/settings/settings.dart';
import 'package:diver/screens/welcome.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WelcomeRoute.page, initial: true),
    AutoRoute(page: SignInRoute.page, path: '/sign-in'),
    AutoRoute(page: RegisterRoute.page, path: '/register'),
    AutoRoute(
      guards: [AuthGuard()],
      page: AppRoute.page,
      path: '/app',
      children: [
        AutoRoute(page: FeedRoute.page, path: 'feed'),
        AutoRoute(page: ChatRoute.page, path: 'chat'),
        AutoRoute(page: SettingsRoute.page, path: 'settings')
      ]
    ),
    RedirectRoute(path: '*', redirectTo: '/sign-in')
  ];
}