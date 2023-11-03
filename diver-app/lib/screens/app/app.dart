import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:diver/constants.dart';
import 'package:diver/screens/posts/new_post.dart';
import 'package:diver/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diver/generated/l10n.dart';

@RoutePage()
class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  bool isExtended = true;
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {}

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(_scrollListener);
  }

  void selectDestination(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        return AppBar(
          automaticallyImplyLeading: false,
          //elevation: 4.0,
          centerTitle: true,
          title: Text(
            "Diver",
            style: GoogleFonts.yesevaOne(fontSize: 32.0),
          ),
        );
      },
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: _selectedIndex == 0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildNewPostWidget(context),
            )
          : null,
      routes: const [FeedRoute(), ChatRoute(), ChatRoute()],
      /*body: PageTransitionSwitcher(
        reverse: _selectedIndex != 0,
        transitionBuilder: (Widget child, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return FadeThroughTransition(
            //transitionType: SharedAxisTransitionType.horizontal,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _pages[_selectedIndex],
      ),*/
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: (int idx) => tabsRouter.setActiveIndex(idx),
          indicatorColor: Theme.of(context).colorScheme.primary,
          destinations: <NavigationDestination>[
            NavigationDestination(
              selectedIcon: const Icon(Icons.home,
                  size: 20.0, color: kContentColorDarkTheme),
              icon: const Icon(
                Icons.home,
                size: 20.0,
              ),
              label: S.of(context).navigationBarHome,
            ),
            NavigationDestination(
              selectedIcon: const Icon(
                Icons.chat_bubble,
                size: 20.0,
                color: kContentColorDarkTheme,
              ),
              icon: const Icon(Icons.chat_bubble, size: 20.0),
              label: S.of(context).navigationChat,
            ),
            NavigationDestination(
              selectedIcon: const Icon(
                Icons.settings,
                size: 20.0,
                color: kContentColorDarkTheme,
              ),
              icon: const Icon(
                Icons.settings,
                size: 20.0,
              ),
              label: S.of(context).navigationSettings,
            ),
          ],
        );
      },
    );
  }

  Widget _buildNewPostWidget(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return const NewPost();
      },
      closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      closedColor: Theme.of(context).colorScheme.primary,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return const SizedBox(
          height: 56,
          width: 56,
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
