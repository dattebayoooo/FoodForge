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
    ingredients: [
      Ingredient(name: 'Спагетти', amount: '200 г'),
      Ingredient(name: 'Бекон', amount: '150 г'),
      Ingredient(name: 'Сливки', amount: '100 мл'),
      Ingredient(name: 'Пармезан', amount: '50 г'),
    ],
    instructions: [
      'Отварите пасту согласно инструкции на упаковке.',
      'Обжарьте бекон до хрустящей корочки.',
      'Добавьте сливки и прогрейте 2 минуты.',
      'Смешайте с пастой и посыпьте пармезаном.',
    ],
  ),
  Recipe(
    id: '2',
    name: 'Омлет',
    imageUrl: 'assets/images/omlet.png',
    cookingTime: '10 мин',
    ingredients: [
      Ingredient(name: 'Яйца', amount: '3 шт'),
      Ingredient(name: 'Молоко', amount: '50 мл'),
      Ingredient(name: 'Соль', amount: 'по вкусу'),
    ],
    instructions: [
      'Взбейте яйца с молоком и солью.',
      'Вылейте на разогретую сковороду.',
      'Жарьте на среднем огне 5-7 минут.',
    ],
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