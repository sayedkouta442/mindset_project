import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindset_project/manager/product_cubit/product_cubit.dart';
import 'package:mindset_project/views/cart_view.dart';
import 'package:mindset_project/views/favorites.dart';
import 'package:mindset_project/views/home_view.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({super.key});

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductCubit>().fetchProducts();
    });
  }

  final List<Widget> _screens = [
    const HomeView(),
    FavoritesPage(),
    CartPage(),
    const SizedBox(),
    const SizedBox(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color:
                  isDarkMode
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.05),
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey.shade400,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 5.0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: 'Bag',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail_outline),
                label: 'Mail',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
