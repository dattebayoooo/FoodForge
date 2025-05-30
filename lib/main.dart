import 'package:flutter/material.dart';
import 'package:food_forge/pages/home_page.dart';
import 'package:food_forge/pages/favorites_page.dart';
import 'package:food_forge/pages/search_page.dart';
import 'package:food_forge/pages/settings_page.dart';
import 'package:food_forge/models/recipe_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Forge',
      theme: ThemeData(primarySwatch: Colors.blue),
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
  final List<Recipe> _allRecipes = [
    Recipe(
      id: '1',
      name: 'Паста Карбонара',
      imageUrl: 'assets/images/pasta.png',
      cookingTime: '25 мин',
      ingredients: ['паста', 'бекон', 'яйца', 'сыр'],
    ),
    Recipe(
      id: '2',
      name: 'Омлет',
      imageUrl: 'assets/images/omlet.png',
      cookingTime: '10 мин',
      ingredients: ['яйца', 'молоко', 'соль'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(currentIndex: _currentIndex, onTabSelected: _changePage),
          FavoritesPage(
            currentIndex: _currentIndex,
            onTabSelected: _changePage,
            allRecipes: _allRecipes,
          ),
          SearchPage(
            currentIndex: _currentIndex,
            onTabSelected: _changePage,
            allRecipes: _allRecipes,
          ),
          SettingsPage(currentIndex: _currentIndex, onTabSelected: _changePage),
        ],
      ),
      
    );
  }

  void _changePage(int index) => setState(() => _currentIndex = index);
}