import 'package:flutter/material.dart';
import 'package:reader/settings.dart';
import 'book_shelf.dart';

Future main() async {
  // await DBManager.instance.isar;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reading App',
      home: HomeTabBar(),
    );
  }
}

class HomeTabBar extends StatefulWidget {
  @override
  _HomeTabBarState createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    BookshelfPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Bookshelf',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
