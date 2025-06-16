import 'package:flutter/material.dart';
import 'package:reader/settings.dart';
import 'package:reader/services/settings_service.dart';
import 'book_shelf.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load user settings during app bootstrap
  await SettingsService.instance.loadSettings();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsService.instance.currentSettings;
    
    return MaterialApp(
      title: 'Reading App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settings.useDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HomeTabBar(),
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
