import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/logo.png'),
        const SizedBox(width: 12),
        const Text(
          'Wizo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Image.asset('assets/images/notification.png', color: Colors.black),
        const SizedBox(width: 20),
        Image.asset('assets/images/Favourite-Heart.png', color: Colors.black),
      ],
    );
  }
}
