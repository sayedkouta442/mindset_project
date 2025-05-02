import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindset_project/manager/categories_cubit/categories_cubit.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesCubit()..fetchCategories(),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesLoaded) {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == state.categories.length - 1 ? 0 : 17,
                      left: index == 0 ? 0 : 17,
                      top: 8,
                      bottom: 8,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // handle category tap
                      },
                      child: CategoriesListViewItem(
                        image: category['image'].toString(),
                        color: category['color'],
                        title: category['title'],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is CategoriesError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class CategoriesListViewItem extends StatelessWidget {
  const CategoriesListViewItem({
    super.key,
    required this.image,
    required this.color,
    required this.title,
  });
  final String image;
  final Color color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color, //Constants.primaryColor.withOpacity(.05),
          ),
          child: Image.network(image),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
