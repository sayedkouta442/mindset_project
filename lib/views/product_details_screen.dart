import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindset_project/constants.dart';
import 'package:mindset_project/manager/cart_cubit/cart_cubit.dart';
import 'package:mindset_project/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindset_project/manager/product_details_cubit.dart/product_details_cubit.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentPage = 0;
  int _selectedColorIndex = 1;
  int _quantity = 1;
  bool isTapped = false;
  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  final List<Color> _availableColors = [
    const Color(0xFFF5E8D9),
    const Color(0xFF808080),
    const Color(0xFFD8BFD8),
    const Color(0xFFB0C4DE),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsCubit>().fetchProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ProductDetailsLoaded) {
            final product = state.product;

            return CustomScrollView(
              slivers: [
                _buildAppBar(),
                _buildImageSlider(product['image_url'] ?? ''),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'] ?? 'Product Title',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$${product['price']} / ',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\$${product['original_price']}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildSaleBadge(),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildRatingsRow(
                          product['rating'].toString(),
                          product['likes'],
                          product['reviews_count'].toString(),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Color',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildColorSelector(),
                        const SizedBox(height: 20),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product['description'] ?? 'No description available.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Specifications',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildSpecColumn('Model Name', 'Color'),
                            const Spacer(),
                            _buildSpecColumn(
                              product['model_name'] ?? 'Unknown',
                              product['color'] ?? 'Unknown',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildBottomControls(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink(); // Fallback
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black54),
          onPressed: () {},
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.black54),
              onPressed: () {},
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                child: const Text(
                  '1',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildImageSlider(String imageUrl) {
    final List<String> images = List.generate(4, (_) => imageUrl);

    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: 250,
            child: PageView.builder(
              itemCount: images.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Image.network(images[index], fit: BoxFit.contain),
                  ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentPage == index
                            ? Colors.black87
                            : Colors.grey.shade300,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaleBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_offer_outlined,
            color: Colors.purple.shade700,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            'On sale',
            style: TextStyle(
              color: Colors.purple.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingsRow(String rate, String likes, String reviews) {
    return Row(
      children: [
        _buildRatingChip(
          Icons.star,
          rate,
          Colors.orange.shade100,
          Colors.orange.shade800,
        ),
        const SizedBox(width: 8),
        _buildRatingChip(
          Icons.thumb_up_alt,
          likes,
          Colors.blue.shade100,
          Colors.blue.shade800,
        ),
        const SizedBox(width: 16),
        Text(reviews, style: TextStyle(color: Colors.black, fontSize: 14)),
      ],
    );
  }

  Widget _buildRatingChip(IconData icon, String rating, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: fg, size: 16),
          const SizedBox(width: 4),
          Text(
            rating,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSelector() {
    return Row(
      children: List.generate(_availableColors.length, (index) {
        return GestureDetector(
          onTap: () => setState(() => _selectedColorIndex = index),
          child: Container(
            margin: const EdgeInsets.only(right: 12.0),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  _selectedColorIndex == index
                      ? Border.all(color: Colors.black, width: 2.0)
                      : null,
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: _availableColors[index],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSpecColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQuantitySelector(),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),

              onPressed: () async {
                context.read<CartCubit>().addToCart(
                  productId: widget.productId,
                  userId: userId,
                  quantity: _quantity,
                  selectedColor: _availableColors[_selectedColorIndex].value
                      .toRadixString(16),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added to cart')),
                );
              },

              child: Row(
                children: [
                  Image.asset('assets/images/cart.png', color: Colors.white),
                  const SizedBox(width: 6),
                  const Text('Buy now', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: () async {
                  context.read<FavoritesCubit>().addToFavorites(
                    productId: widget.productId,
                    userId: userId,
                  );
                  setState(() {
                    isTapped = !isTapped;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to favorites')),
                  );
                },

                child: Icon(
                  isTapped ? Icons.favorite : Icons.favorite_border_outlined,
                  color: Colors.purple.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: _decrementQuantity,
            child: const Icon(Icons.remove, size: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '$_quantity',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: _incrementQuantity,
            child: const Icon(Icons.add, size: 20),
          ),
        ],
      ),
    );
  }
}
