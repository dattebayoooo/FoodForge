import 'package:flutter/material.dart';
import 'package:food_forge/assents.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Color activeColor;
  final Color inactiveColor;
  final Color iconColor;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    this.activeColor = const Color(0xffbe464f),
    this.inactiveColor = Colors.transparent, // Изменили на прозрачный
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Единая высота
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.intensepink, // Полупрозрачный белый
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          _buildNavItem(0, Icons.play_arrow_outlined, 58),
          _buildNavItem(1, Icons.favorite_border_outlined, 38),
          _buildNavItem(2, Icons.search, 38),
          _buildNavItem(3, Icons.settings_outlined, 38),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, double size) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTabSelected(index),
          borderRadius: _getBorderRadius(index),
          splashColor: activeColor.withOpacity(0.2),
          highlightColor: Colors.transparent,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: isSelected ? activeColor : inactiveColor,
              borderRadius: _getBorderRadius(index),
            ),
            child: Icon(icon, size: size, color: iconColor),
          ),
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      );
    } else if (index == 3) {
      return const BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      );
    }
    return BorderRadius.zero;
  }
}