import 'package:flutter/material.dart';
import 'package:mindset_project/manager/product_cubit/product_cubit.dart';

import 'package:mindset_project/widgets/categories_header.dart';
import 'package:mindset_project/widgets/categories_list_view.dart';
import 'package:mindset_project/widgets/home_view_header.dart';
import 'package:mindset_project/widgets/product_category.dart';
import 'package:mindset_project/widgets/search_text_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: const Color(0xfff9f9f9),
                expandedHeight: 350,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: const [
                          HomeViewHeader(),
                          SizedBox(height: 30),
                          SearchTextField(),
                          SizedBox(height: 30),
                          CategoriesHeader(title: 'Categories'),
                          SizedBox(height: 16),
                          SizedBox(height: 100, child: CategoriesListView()),
                          SizedBox(height: 20),
                          CategoriesHeader(title: 'Featured Products'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (state is ProductLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (state is ProductError)
                SliverFillRemaining(
                  child: Center(child: Text('Error: ${state.message}')),
                ),
              if (state is ProductLoaded)
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((
                      BuildContext context,
                      int index,
                    ) {
                      final product = state.products[index];
                      return ProductCategory(product: product);
                    }, childCount: state.products.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 24,
                          childAspectRatio: .95,
                        ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}




//'assets/images/food_service.png'