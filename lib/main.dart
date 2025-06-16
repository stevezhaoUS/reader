import 'package:flutter/material.dart';
import 'package:reader/settings.dart';
import 'package:reader/services/settings_service.dart';
import 'package:reader/models/user_settings.dart';
import 'book_shelf.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load user settings during app bootstrap
  await SettingsService.instance.loadSettings();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late UserSettings _currentSettings;

  @override
  void initState() {
    super.initState();
    _currentSettings = SettingsService.instance.currentSettings;
  }

  // Method to refresh the app when settings change
  void _refreshApp() {
    setState(() {
      _currentSettings = SettingsService.instance.currentSettings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reading App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _currentSettings.useDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeTabBar(onSettingsChanged: _refreshApp),
    );
  }
}

class HomeTabBar extends StatefulWidget {
  final VoidCallback? onSettingsChanged;
  
  const HomeTabBar({super.key, this.onSettingsChanged});

  @override
  HomeTabBarState createState() => HomeTabBarState();
}

class HomeTabBarState extends State<HomeTabBar> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const BookshelfPage(),
      SettingsPage(onSettingsChanged: widget.onSettingsChanged),
    ];
  }

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
