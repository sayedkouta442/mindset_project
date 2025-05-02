import 'package:flutter/material.dart';
import 'package:mindset_project/constants.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentPage = 0;
  int _selectedColorIndex = 1;
  int _quantity = 1;

  final List<String> _images = [
    'assets/images/headphone2.png',
    'assets/images/headphone2.png',
    'assets/images/headphone2.png',
    'assets/images/headphone2.png',
  ];

  final List<Color> _availableColors = [
    const Color(0xFFF5E8D9),
    const Color(0xFF808080),
    const Color(0xFFD8BFD8),
    const Color(0xFFB0C4DE),
  ];

  void _incrementQuantity() {
    setState(() => _quantity++);
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            floating: false,

            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black54,
                ),
                onPressed: () {},
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.black54,
                    ),
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
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
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
          ),

          // PageView Section (image slider)
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 250,
                  child: PageView.builder(
                    itemCount: _images.length,
                    onPageChanged:
                        (index) => setState(() => _currentPage = index),
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Image.asset(
                            _images[index],
                            //    fit: BoxFit.contain,
                          ),
                        ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_images.length, (index) {
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
                // const SizedBox(height: 16),
              ],
            ),
          ),

          // Product Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Headphone',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '\$155 / ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            TextSpan(
                              text: ' \$300',
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Ratings
                  Row(
                    children: [
                      _buildRatingChip(
                        Icons.star,
                        '4.2',
                        Colors.orange.shade100,
                        Colors.orange.shade800,
                      ),
                      const SizedBox(width: 8),
                      _buildRatingChip(
                        Icons.thumb_up_alt,
                        '3.8',
                        Colors.blue.shade100,
                        Colors.blue.shade800,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        '132 Reviews',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Color',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(_availableColors.length, (index) {
                      return GestureDetector(
                        onTap:
                            () => setState(() => _selectedColorIndex = index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12.0),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                _selectedColorIndex == index
                                    ? Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    )
                                    : null,
                          ),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: _availableColors[index],
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Our compact and foldable Bluetooth earbuds are renowned for their lightweight build, offering a convenient and porable solution for audiophiles on the go',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Specifications',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildSpecColumn('Model Name', 'Color'),
                      Spacer(),
                      _buildSpecColumn('Boat Airdopes 121V2', 'Gray'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildQuantitySelector(),
                          Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.primaryColor,
                            ),
                            onPressed: () {},

                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/cart.png',
                                  color: Colors.white,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Buy now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.purple.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
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

  Widget _buildSpecColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          SizedBox(height: 4),
          Text(value, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Constants.primaryColor),
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
