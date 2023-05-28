import 'package:flutter/material.dart';
import 'package:spielblock/screens/new_game.dart';
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
    const Center(child: Text('Settings')),
  ];

  void _selectPage(int index) {
    if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const NewGameScreen(),
        ),
      );
      index = _currentPageIndex;
    }
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Games',
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
