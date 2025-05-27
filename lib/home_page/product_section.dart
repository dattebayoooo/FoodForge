import 'package:flutter/material.dart';
import 'package:food_forge/assents.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSection extends StatelessWidget {
  final List<String> products;
  final Function(int) onRemove;

  const ProductSection({
    super.key,
    required this.products,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    List<List<String>> rows = [];
    for (int i = 0; i < products.length; i += 3) {
      int end = (i + 3 < products.length) ? i + 3 : products.length;
      rows.add(products.sublist(i, end));
    }

    return Column(
      children: [
        Text(
          'Ваши продукты:',
          style: GoogleFonts.montserratAlternates(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.brown,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: rows.map((row) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: row.asMap().entries.map((entry) {
                  final index = products.indexOf(entry.value);
                  return GestureDetector(
                    onTap: () => onRemove(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.pink,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            entry.value,
                            style: GoogleFonts.montserratAlternates(
                              color: AppColor.intensepink,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            AppIcons.cross,
                            size: 20,
                            color: AppColor.brown,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}