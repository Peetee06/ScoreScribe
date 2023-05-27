import 'package:flutter/material.dart';
import 'package:spielblock/data/dummy_games.dart';
import 'package:spielblock/widgets/games_list.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    GamesList(dummyGames),
    const Center(child: Text('New Game')),
    const Center(child: Text('Settings')),
  ];

  void _selectPage(int index) {
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
