import 'package:flutter/material.dart';
import 'package:food_forge/pages/home_page.dart';
import 'package:food_forge/pages/favorites_page.dart';
import 'package:food_forge/pages/search_page.dart';
import 'package:food_forge/pages/settings_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Forge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  void _changePage(int index) => setState(() => _currentIndex = index);

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0: return HomePage(currentIndex: _currentIndex, onTabSelected: _changePage);
      case 1: return FavoritesPage(currentIndex: _currentIndex, onTabSelected: _changePage);
      case 2: return SearchPage(currentIndex: _currentIndex, onTabSelected: _changePage);
      case 3: return SettingsPage(currentIndex: _currentIndex, onTabSelected: _changePage);
      default: return HomePage(currentIndex: 0, onTabSelected: _changePage);
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: _getCurrentPage(), // Без bottomNavigationBar здесь
  );
}
}