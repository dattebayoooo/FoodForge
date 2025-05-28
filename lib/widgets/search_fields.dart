import 'package:flutter/material.dart';

import 'package:food_forge/assets/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFields extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  const SearchFields({
    super.key,
    required this.placeholder,
    this.controller,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColor.pink,
              borderRadius: BorderRadius.circular(32),
            ),
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: GoogleFonts.montserratAlternates(
                  color: AppColor.intensepink,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
