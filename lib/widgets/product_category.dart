import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindset_project/constants.dart';
import 'package:mindset_project/manager/cart_cubit/cart_cubit.dart';
import 'package:mindset_project/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindset_project/manager/product_details_cubit.dart/product_details_cubit.dart';
import 'package:mindset_project/views/product_details_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductCategory extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCategory({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProductDetails(context),
      child: _buildProductContainer(),
    );
  }

  void _navigateToProductDetails(BuildContext context) {
    final String productId = product['id'].toString();
    if (productId.isEmpty) {
      debugPrint("Invalid product ID");
      return;
    }
    final supabase = Supabase.instance.client;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (_) =>
                          ProductDetailsCubit()..fetchProductDetails(productId),
                ),
                BlocProvider(
                  create: (_) => CartCubit(supabase, Constants.userId),
                ),
                BlocProvider(
                  create: (_) => FavoritesCubit(supabase, Constants.userId),
                ),
              ],
              child: ProductDetailScreen(productId: productId),
            ),
      ),
    );
  }

  Widget _buildProductContainer() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildProductImage(), _buildProductDetails()],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: Image.network(product['image_url'], fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product['title'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          _buildPriceAndCart(),
        ],
      ),
    );
  }

  Widget _buildPriceAndCart() {
    return Row(
      children: [
        Expanded(
          child: Text(
            '\$${product['price']}',
            style: TextStyle(
              color: Constants.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Image.asset('assets/images/cart2.png', width: 25, height: 25),
      ],
    );
  }
}
