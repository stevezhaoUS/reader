import 'package:flutter/material.dart';
import 'package:reader/settings.dart';
import 'book_shelf.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Reading App',
      home: HomeTabBar(),
    );
  }
}

class HomeTabBar extends StatefulWidget {
  const HomeTabBar({super.key});

  @override
  HomeTabBarState createState() => HomeTabBarState();
}

class HomeTabBarState extends State<HomeTabBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const BookshelfPage(),
    const SettingsPage(),
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
