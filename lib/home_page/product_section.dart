import 'package:flutter/material.dart';
import 'package:food_forge/assents.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSection extends StatelessWidget {
  final List<String> products;

  const ProductSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    // Разделяем список на группы по 3 элемента для создания строк
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
        SizedBox(height: 8),
        Column(
          children:
              rows.map((row) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                        row.map((product) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColor.pink,
                              borderRadius: BorderRadius.all(
                                Radius.circular(32),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 8),
                                Text(
                                  product,
                                  style: GoogleFonts.montserratAlternates(
                                    color: AppColor.intensepink,
                                    fontSize: 16,
                                  ),
                                ),

                                Icon(
                                  AppIcons.cross,
                                  size: 20,
                                  color: AppColor.brown,
                                ),
                                const SizedBox(width: 4),
                              ],
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
