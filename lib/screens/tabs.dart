import 'package:flutter/material.dart';
import 'package:spielblock/screens/new_game.dart';
import 'package:spielblock/screens/settings.dart';
import 'package:spielblock/widgets/games.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentPageIndex = 0;

  // TODO: Refactor this to more nicely handle the different pages.
  final List<Widget> _pages = <Widget>[
    const Games(),
    const Text('Dummy'),
    const SettingsScreen(),
  ];
  final List<String> _pageTitles = <String>[
    'Games',
    'New Game',
    'Settings',
  ];

  void _selectPage(int index) {
    int animationDuration = 200;
    if (index == 1) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              const NewGameScreen(),
          transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
            var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: animationDuration),
        ),
      );

      // Go back to games screen when returning from new game screen.
      // wait 200 miliseconds to allow the animation to finish.
      Future.delayed(Duration(milliseconds: animationDuration), () {
        setState(() {
          _currentPageIndex = 0;
        });
      });
      index = 0;
    } else {
      setState(() {
        _currentPageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pageTitles[_currentPageIndex],
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  )),
        ),
        body: _pages[_currentPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: _selectPage,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.casino,
              ),
              icon: Icon(Icons.casino_outlined),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.add_box_rounded),
              icon: Icon(Icons.add_box_outlined),
              label: 'New Game',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ));
  }
}
