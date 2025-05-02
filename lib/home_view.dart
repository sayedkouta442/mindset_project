import 'package:flutter/material.dart';

import 'package:mindset_project/widgets/categories_header.dart';
import 'package:mindset_project/widgets/categories_list_view.dart';
import 'package:mindset_project/widgets/product_category.dart';
import 'package:mindset_project/widgets/search_text_field.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xfff9f9f9),
            expandedHeight: 512, //500
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
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

                          Spacer(),
                          Image.asset(
                            'assets/images/notification.png',
                            color: Colors.black,
                          ),
                          const SizedBox(width: 20),
                          Image.asset(
                            'assets/images/Favourite-Heart.png',
                            color: Colors.black,
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      SearchTextField(),
                      SizedBox(height: 30),
                      CategoriesHeader(title: 'Categories'),
                      SizedBox(height: 16),
                      SizedBox(height: 100, child: CategoriesListView()),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          width: double.infinity,
                          height: 150,
                          'assets/images/Action_box.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 20),
                      CategoriesHeader(title: 'Featured Products'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((
                BuildContext context,
                int index,
              ) {
                return GestureDetector(onTap: () {}, child: ProductCategory());
              }, childCount: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 24,
                childAspectRatio: .95,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



//'assets/images/food_service.png'