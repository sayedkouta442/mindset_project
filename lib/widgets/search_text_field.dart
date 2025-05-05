import 'package:flutter/material.dart';
import 'package:mindset_project/constants.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        contentPadding: EdgeInsets.all(12),
        prefixIcon: Image.asset(
          'assets/images/SearchBottom.png',
          color: primaryColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        //  prefix: Image.asset('assets/images/SearchBottom.png'),
      ),
    );
  }
}
