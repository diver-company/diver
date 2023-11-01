import 'package:animations/animations.dart';
import 'package:diver/constants.dart';
import 'package:diver/screens/chat/chat.dart';
import 'package:diver/screens/feed/feed.dart';
import 'package:diver/screens/new_post/new_post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[const Feed(), const Chat(), const Chat()];

  void selectDestination(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        centerTitle: true,
        title: Text(
          "Diver",
          style: GoogleFonts.yesevaOne(fontSize: 32.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: _selectedIndex == 0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildNewPostWidget(context),
            )
          : null,
      body: PageTransitionSwitcher(
        reverse: _selectedIndex != 0,
        transitionBuilder: (Widget child, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return SharedAxisTransition(
            transitionType: SharedAxisTransitionType.horizontal,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int idx) => selectDestination(idx),
        indicatorColor: Theme.of(context).colorScheme.primary,
        destinations: const <NavigationDestination>[
          NavigationDestination(
              selectedIcon:
                  Icon(Icons.home, size: 20.0, color: kContentColorDarkTheme),
              icon: Icon(
                Icons.home,
                size: 20.0,
              ),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(Icons.chat_bubble,
                  size: 20.0, color: kContentColorDarkTheme),
              icon: Icon(Icons.chat_bubble, size: 20.0),
              label: "Chat"),
          NavigationDestination(
            icon: Icon(
              Icons.settings,
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Widget _buildNewPostWidget(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.android
        ? OpenContainer(
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
          )
        : FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed('/feed/new-post'),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          );
  }
}
