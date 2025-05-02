import 'package:flutter/material.dart';
import 'package:mindset_project/constants.dart';
import 'package:mindset_project/product_details_screen.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetailScreen();
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(
            16,
          ), // Circular radius for the container
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/earPhone.png',
                          width: double.infinity,
                          //   height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //   const Spacer(flex: 6),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'head Phone',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$199',
                          style: const TextStyle(
                            color: Constants.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,

                            overflow: TextOverflow.ellipsis,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      //  const Spacer(flex: 1),
                      Image.asset(
                        'assets/images/cart2.png',
                        width: 25,
                        height: 25,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //  const Spacer(flex: 8),
          ],
        ),
      ),
    );
  }
}
