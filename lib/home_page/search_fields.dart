import 'package:flutter/material.dart';
import 'package:food_forge/assents.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFields extends StatelessWidget {
  final String placeholder;

  const SearchFields({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: AppColor.pink,
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 24),
                Text(
                  placeholder,
                  style: GoogleFonts.montserratAlternates(
                    color: AppColor.intensepink,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
