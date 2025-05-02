import 'package:flutter/material.dart';
import 'package:mindset_project/constants.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xff424242),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text('See All', style: TextStyle(color: Constants.primaryColor)),
      ],
    );
  }
}
